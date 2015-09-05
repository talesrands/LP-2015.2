
(defun good-enough? (guess x)
  (< (abs (- (* guess guess) x)) 0.001))

(defun average (x y)
  (/ (+ x y) 2))

(defun improve-1 (guess x)
  (average guess (/ x guess)))

(defun improve-2 (guess x)
  (/ (+ (/ x (* guess guess)) (* 2 guess)) 3))


(defun sqrt-iter (guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
		 x)))

(defun my-sqrt (x)
  (sqrt-iter 1.0 x))


(defun my-sqrt-1 (x &optional (previous-guess 0.0) (guess 1.0))
  (if (< (abs (- guess previous-guess)) 0.001) 
      guess
      (my-sqrt-1 x guess (improve guess x))))


(defun my-sqrt-2 (x &key (previous-guess 0.0) (guess 1.0) (func-improve 'improve-1)
		      (precision 0.001))
  (labels ((good? (previous-guess guess)
	     (< (abs (- guess previous-guess)) precision)))
    (if (good? previous-guess guess)
	guess
	(my-sqrt-2 x :previous-guess guess :guess (funcall func-improve guess x)
		   :func-improve func-improve :precision precision))))




;; to test
;; http://malisper.me/2015/08/19/debugging-lisp-part-5-miscellaneous/

