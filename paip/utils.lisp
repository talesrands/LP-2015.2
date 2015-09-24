;;; Code from Paradigms of Artificial Intelligence Programming
;;; Copyright (c) 1991 Peter Norvig
;;; Website http://norvig.com/paip.html

(in-package :utils)

(setf (symbol-function 'find-all-if) #'remove-if-not)

(defun one-of (set)
  "Pick one element of set, and make a list of it."
  (list (random-elt set)))

(defun random-elt (choices)
  "Choose an element from a list at random."
  (elt choices (random (length choices))))

(defun mappend (fn the-list)
  "Apply fn t o each element of list and append the results."
  (apply 'append (mapcar fn the-list)))


(defun find-all (item sequence &rest keyword-args
		 &key (test #'eql) test-not &allow-other-keys)
  (if test-not
      (apply #'remove item sequence
	     :test-not (complement test-not) keyword-args)
      (apply #'remove item sequence
	     :test (complement test) keyword-args)))


(defun cross-product (fn xlist ylist)
  (mappend #'(lambda (y)
	       (mapcar #'(lambda (x) (funcall fn x y))
		       xlist))
	   ylist))

(defun combine-all (xlist ylist)
  (cross-product #'append xlist ylist))

(defun insert (lst index newelement)
  (cond ((null lst) (list newelement))
	((= 0 index) (cons newelement lst))
	(t (push newelement (cdr (nthcdr (1- index) lst))) 
	   lst)))

(defun construct-candidates (part element)
  (loop for i from 0 to (length part)
       collect (insert (copy-list part) i element)))

(defun permutations-backtrack (part n newlist)
  (if (= n (length part))
      (list part)
      (let*((candidates (construct-candidates part (car newlist))))
	(apply 'append (mapcar 'permutations-backtrack candidates (make-list n :initial-element n) (make-list n :initial-element (cdr newlist)))))))  

(defun generate-permutations (alist)
 (permutations-backtrack nil (length alist) alist))


