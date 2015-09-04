
(defun range (d &optional (b 0) (c 1))
  (loop repeat d for a from b by c collect a))

(defun range-1 (a b)
  (let ((res nil))
    (dotimes (x 10 (reverse res))
      (push x res))))

(defun range-2 (&key (max -1) (min 0) (step 1))
 (when (< min  max) 
  (cons min (range-2 :max max :min (+ min step) :step step))))


(defun steps-number (max min step)
  (if (= (mod (- max min) step) 0)
      (/ (- (- max step) min) step)
      (/ (- max min) step)))

(defun range-3 (&key (min 0) max (step 1))
  (loop for x from 0 to (steps-number max min step)
	collect (+ min (* x step))))

