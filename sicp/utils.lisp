

(defun range-1 (a b)
  (let ((res nil))
    (dotimes (x 10 (reverse res))
      (push x res))))

(defun range (d &optional (b 0) (c 1))
  (loop repeat d for a from b by c collect a))

