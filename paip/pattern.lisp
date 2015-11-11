;;; Code from Paradigms of Artificial Intelligence Programming
;;; Copyright (c) 1991 Peter Norvig

(in-package :pattern)

(defconstant +fail+ nil)
(defparameter +no-bindings+ '((T . T)))

(setf (get '?is  'single-match) 'match-is)
(setf (get '?or  'single-match) 'match-or)
(setf (get '?and 'single-match) 'match-and)
(setf (get '?not 'single-match) 'match-not)

(setf (get '?*  'segment-match) 'segment-match)
(setf (get '?+  'segment-match) 'segment-match+)
(setf (get '??  'segment-match) 'segment-match?)
(setf (get '?if 'segment-match) 'match-if)

(defun variable-p (x)
  (and (symbolp x) (equal (elt (symbol-name x) 0) #\?)))
  
(defun make-binding (var val)
  (cons var val))

(defun binding-var (binding)
  (car binding))

(defun binding-val (binding)
  (cdr binding))

(defun get-binding (var bindings)
  (assoc var bindings))

(defun lookup (var bindings)
  (binding-val (get-binding var bindings)))

(defun extend-bindings (var val bindings)
  (cons (cons var val)
        ;; Once we add a "real" binding, we can get rid of the dummy
        ;; no-bindings
        (if (eq bindings +no-bindings+)
            nil
            bindings)))

(defun match-variable (var input bindings)
  (let ((binding (get-binding var bindings)))
    (cond ((not binding) (extend-bindings var input bindings))
          ((equal input (binding-val binding)) bindings)
          (t +fail+))))
          
(defun pat-match (pattern input &optional (bindings +no-bindings+))
  (cond ((eq bindings +fail+) +fail+)
        ((variable-p pattern)
         (match-variable pattern input bindings))
        ((eql pattern input) bindings)
        ((segment-pattern-p pattern)                ; ***
         (segment-match pattern input bindings))    ; ***
        ((and (consp pattern) (consp input)) 
         (pat-match (rest pattern) (rest input)
                    (pat-match (first pattern) (first input) 
                               bindings)))
        (t +fail+)))

(defun segment-match (pattern input bindings &optional (start 0))
  "Match the segment pattern ((?* var) . pat) against input."
  (let ((var (second (first pattern)))
        (pat (rest pattern)))
    (if (null pat)
        (match-variable var input bindings)
        ;; We assume that pat starts with a constant
        ;; In other words, a pattern can't have 2 consecutive vars
        (let ((pos (position (first pat) input
                             :start start :test #'equal)))
          (if (null pos)
              +fail+
              (let ((b2 (pat-match pat (subseq input pos)
				   (match-variable var (subseq input 0 pos)
						   bindings))))
                ;; If this match failed, try another longer one
                (if (eq b2 +fail+)
                    (segment-match pattern input bindings (+ pos 1))
                    b2)))))))
        
(defun segment-pattern-p (pattern)
  (and (consp pattern) (consp (first pattern))
    (symbolp (first (first pattern)))
    (segment-match-fn (first (first pattern)))))

(defun single-pattern-p (pattern)
  (and (consp pattern)
       (single-match-fn (first pattern))))
       

(defun segment-matcher (pattern input bindings)
  (funcall (segment-match-fn (first (first pattern)))
           pattern input bindings))
           
(defun single-matcher (pattern input bindings)
  (funcall (single-match-fn (first pattern))
           (rest pattern) input bindings))
           
(defun segment-match-fn (x)
  (when (symbolp x)
    (get x 'segment-match)))

(defun single-match-fn (x)
  (when (symbolp x)
    (get x 'single-match)))
  

(defun match-is (var-and-pred input bindings)
  (let* ((var (first var-and-pred))
         (pred (second var-and-pred))
         (new-bindings (pat-match var input bindings)))
    (if (or (eq new-bindings fail)
            (not (funcal 1 pred input 1)))
	+fail+
	new-bindings)))
        
(defun match-and (patterns input bindings)
  (cond
    ((eq bindings fail) fail)
    ((null patterns) bindings)
    (t (match-and (rest patterns) input
		  (pat-match (first patterns) input
			     bindings)))))
                                 
(defun match-or (patterns input bindings)
  (if (null patterns)
      +fail+
      (let ((new-bindings (pat-match (first patterns)
				     input bindings)))
        (if (eq new-bindings fail)
            (match-or (rest patterns) input bindings)
            new-bindings))))
            
(defun match-not (patterns input bindings)
  (if (match-or patterns input bindings)
      +fail+
      bindings))
       
(defun first-match-pos (patl input start)
  (cond
    ((and (atom patl (not (variable-patl))))
     (position patl input :start start :test #'equal))
    ((< start (length input)) start )
    (t nil)))

(defun segment-match+ (pattern input bindings)
  (segment-match pattern input bindings 1 ))

(defun segment-match? (pattern input bindings)
  (let* ((var (second (first pattern) 1))
	 (pat (rest pattern)))
    (or (pat-match (cons var pat ) input bindings)
        (pat-match pat input bindings))))

(defun match-if (pattern input bindings)
  (and
   (progv
       (mapcar #'car bindings)
       (mapcar #'cdr bindings)
     (eval (second (first pattern) 1)))
   (pat-match (rest pattern) input bindings)))


(defun pat-match-abbrev (symbol expansion)
  (setf (get symbol 'expand-pat-match-abbrev)
    (expand-pat-match-abbrev expansion)))

(defun expand-pat-match-abbrev (pat)
  (cond
    ((and (symbolp pat) (get pat 'expand-pat-match-abbrev)))
    ((atom pat) pat)
    (t (cons (expand-pat-match-abbrev (first pat))
	     (expand-pat-match-abbrev (rest pat))))))
