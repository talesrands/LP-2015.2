;;; Code from Paradigms of Artificial Intelligence Programming
;;; Copyright (c) 1991 Peter Norvig
;;; Website http://norvig.com/paip.html

(in-package :chapter-1)

(defun generate-tree (phrase)
  (cond 
    ((list phrase)
     (mapcar #'generate-tree phrase))
    ((rewrites phrase)
     (cons phrase
	   (generate-tree (random-elt (rewrites phrase)))))
    (t (list phrase))))
   
