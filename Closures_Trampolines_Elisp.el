(setq test (lexical-let ((foo "bar"))
	     (lambda () 
	       foo)))

(funcall test)

(let ((foo "something-else"))
  (funcall test))

(defun range (s e &optional res)
  (let ((res (cons s res)))
   (if (eql s e)
      (reverse res)
      (range (if (< s e) (+ 1 s) (- 1 s)) e res))))

(range 1 4)

(range 1 31181)

(defun trampoline (fn &rest args)
  (progn
    (message "%s" fn)
    (setf v (apply fn args))
    (while (functionp v)
      (message "%s" v)
      (setf v (funcall v)))
    v))

(defun range (s e &optional res)
  (let ((res (cons s res)))
    (if (eql s e)
        (reverse res)
      (lambda ()
        (range
         (if (< s e) (+ 1 s) (- 1 s))
         e
         res)))))

(trampoline #'range 1 4)
