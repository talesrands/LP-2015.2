(defun cross-product (fn xlist ylist)
  (mappend #'(lambda (y)
	       (mapcar #'(lambda (x) (funcall fn x y))
		       xlist))
	   ylist))

(defun combine-all (xlist ylist)
  (cross-product #'append xlist ylist))
