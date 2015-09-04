(defun number? (x)
  (typep x 'integer))

(defun =number? (exp num)
  (and (number? exp) (= exp num)))

(defun variable? (x)
  (atom x))

(defun same-variable? (v1 v2)
  (and (variable? v1)
       (variable? v2)
       (eq v1 v2)))

(defun make-sum (a1 a2)
  (cond ((=number? a1 0) a2)
	((=number? a2 0) a1)
	((and (number? a1) (number? a2))
	 (+ a1 a2))
	(t (list '+ a1 a2))))

(defun make-product (m1 m2)
  (cond ((or (=number? m1 0)
	     (=number? m2 0)) 0)
	((=number? m1 1) m2)
	((=number? m2 1) m1)
	((and (number? m1)
	      (number? m2))
	 (* m1 m2))
	(t (list '* m1 m2))))

(defun sum? (x)
  (and (pair? x) (eq (car x) '+)))

(defun product? (x)
  (and (pair? x) (eq (car x) '*)))

(defun addend (s)
  (cadr s))

(defun augend (s)
  (caddr s))

(defun multiplier (p)
  (cadr p))

(defun multiplicand (p)
  (caddr p))

(defun deriv (exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (deriv (multiplier exp) var)
                         (multiplicand exp))))
        (t (error "unknown expression type -- DERIV" exp))))
