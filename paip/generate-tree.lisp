
(defun generate-tree(phrase)
  (cond 
    ((list phrase)
     (mapcar #'generate-tree phrase))
    ((rewrites phrase)
     (cons phrase
	   (generate-tree (random-elt (rewrites phrase)))))
    (t (list phrase))))
   
