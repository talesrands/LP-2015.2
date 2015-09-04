(defun pair? (x)
  (and (not (atom x)) (not (null x))))

(defun make-exponentiation (b e)
  (cond ((=number? e 0) 1)
	((=number? e 1) b)
	(t (list '** b e))))

(defun exponentiation? (x)
  (and (pair? x) (eq (car x) '**)))

(defun base (e)
  (cadr e))

(defun exponent (e)
  (caddr e))
