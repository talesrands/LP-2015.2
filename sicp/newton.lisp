
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


(defun range-1 (a b)
  (let ((res nil))
    (dotimes (x 10 (reverse res))
      (push x res))))

(defun steps-number (max min step)
  (if (= (mod (- max min) step) 0)
      (/ (- (- max step) min) step)
      (/ (- max min) step)))

(defun range (&key (min 0) max (step 1))
  (loop for x from 0 to (steps-number max min step) collect (+ min (* x step))))

;; to test
;; http://malisper.me/2015/08/19/debugging-lisp-part-5-miscellaneous/

