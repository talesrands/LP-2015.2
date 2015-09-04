
(defun good-enough? (guess x)
  (< (abs (- (* guess guess) x)) 0.001))

(defun average (x y)
  (/ (+ x y) 2))

(defun improve (guess x)
  (average guess (/ x guess)))

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

(defun my-sqrt-2 (x &optional (previous-guess 0.0) (guess 1.0))
  (labels ((good? (previous-guess guess)
	     (< (abs (- guess previous-guess)) 0.001)))
    (if (good? previous-guess guess)
	guess
	(my-sqrt-2 x guess (improve guess x)))))

(defun improve-2 (guess x)
  (/ (+ (/ x (* guess guess)) (* 2 guess)) 3))
  
(defun my-cbrt-3 (x &optional (guess 1.0) (previous-guess 0.0))
  (labels ((good? (previous-guess guess)
		  (< (abs (- guess previous-guess)) 0.0001)))
	  (if (good? previous-guess guess)
	      guess
	    (my cbrt-3 x guess (improve-2 guess x)))))


;; to test
;; http://malisper.me/2015/08/19/debugging-lisp-part-5-miscellaneous/

