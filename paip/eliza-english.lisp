
(in-package :eliza-test)

(defparameter *eliza-rules*
 '((((?* ?x) hello (?* ?y))      
    (How do you do.  Please state your problem.))
   (((?* ?x) I want (?* ?y))     
    (What would it mean if you got ?y)
    (Why do you want ?y)
    (Suppose you got ?y soon))
   (((?* ?x) if (?* ?y)) 
    (Do you really think its likely that ?y)
    (Do you wish that ?y)
    (What do you think about ?y)
    (Really-- if ?y))
   (((?* ?x) no (?* ?y))
    (Why not?)
    (You are being a bit negative)
    (Are you saying "NO" just to be negative?))
   (((?* ?x) I was (?* ?y))       
    (Were you really?)
    (Perhaps I already knew you were ?y)
    (Why do you tell me you were ?y now?))
   (((?* ?x) I feel (?* ?y))     
    (Do you often feel ?y ?))
   (((?* ?x) I felt (?* ?y))     
    (What other feelings do you have?))))


(defun switch-viewpoint (words)
  "Change I to you and vice versa, and so on."
  (sublis '((I . you) (you . I) (me . you) (am . are))
          words))

