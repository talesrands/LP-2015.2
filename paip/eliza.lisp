;;; Code from Paradigms of Artificial Intelligence Programming
;;; Copyright (c) 1991 Peter Norvig


(in-package :eliza)

(defconstant +fail+ nil)
(defparameter +no-bindings+ '((T . T)))

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


(defun variable-p (x)
  "Is x a variable (a symbol beginning with `?')?"
  (and (symbolp x) (equal (elt (symbol-name x) 0) #\?)))

(defun pat-match (pattern input)
  (if (variable-p pattern)
      t
      (if (or (atom pattern) (atom input))
	  (eql pattern input)
	  (and (pat-match (car pattern) (car input))
	       (pat-match (cdr pattern) (cdr input))))))

(defun pat-match (pattern input)
  (if (variable-p pattern)
      t
      (if (or (atom pattern) (atom input))
	  (eql pattern input)
	  (every #'pat-match pattern input))))

(defun pat-match (pattern input)
  (if (variable-p pattern)
      (list (cons pattern input))
      (if (or (atom pattern) (atom input))
	  (eql pattern input)  ; nil falha tb
	  (append (pat-match (car pattern) (car input))
		  (pat-match (cdr pattern) (cdr input))))))


(defun match-variable (var input bindings)
  (let ((binding (get-binding var bindings)))
    (cond ((not binding) (extend-bindings var input bindings))
          ((equal input (binding-val binding)) bindings)
          (t +fail+))))

(defun pat-match (pattern input &optional (bindings +no-bindings+))
  (cond ((eq bindings +fail+) +fail+)
        ((variable-p pattern)
	 (match-variable pattern input bindings))
        ((eql pattern input)
	 bindings)
        ((and (consp pattern) (consp input))
         (pat-match (rest pattern) (rest input)
                    (pat-match (first pattern) (first input) bindings)))
        (t +fail+)))


(defun segment-pattern-p (pattern)
  (and (consp pattern)
       (starts-with (first pattern) '?*)))


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
        ;; We assume that pat starts with a constant In other words, a
        ;; pattern can't have 2 consecutive vars
        (let ((pos (position (first pat) input
                             :start start :test #'equal)))
          (if (null pos)
              +fail+
              (let ((b2 (pat-match pat (subseq input pos) bindings)))
                ;; If this match failed, try another longer one If it
                ;; worked, check that the variables match
                (if (eq b2 +fail+)
                    (segment-match pattern input bindings (+ pos 1))
                    (match-variable var (subseq input 0 pos) b2))))))))


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



(defun rule-pattern (rule) (first rule))
(defun rule-responses (rule) (rest rule))

(defparameter *rules* nil)

(defun use-eliza-rules (input &key (rules *rules*) (preproc #'identity))
  "Find some rule with which to transform the input."
  (some #'(lambda (rule)
            (let ((result (pat-match (rule-pattern rule) input)))
              (if (not (eq result +fail+))
                  (sublis (funcall preproc result)
                          (random-elt (rule-responses rule))))))
        rules))


(defun eliza (rules preproc)
  "Respond to user input using pattern matching rules."
  (loop
    (print 'eliza-prompt>)
    (let* ((answer 
	    (flatten (use-eliza-rules (read) :rules rules 
				      :preproc preproc))))
      (format t "~{~A ~}" answer)
  (if (every #'utils::eql-by-name-if-symbol answer '(good bye))
      (Return)))))
	
;;(defun eliza (rules preproc)
;;  "Respond to user input using pattern matching rules."
;;  (loop
;;   (print 'eliza-prompt>)
;;    (let* ((answer 
;;	    (flatten (use-eliza-rules (read) :rules rules 
;;				      :preproc preproc))))
;;      (format t "~{~A ~}" answer)
;;  (if (utils::eql-by-name-if-symbol (car (reverse answer)) 'EXIT)
;;      (Return)))))


