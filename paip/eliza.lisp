;;; Code from Paradigms of Artificial Intelligence Programming
;;; Copyright (c) 1991 Peter Norvig


(in-package :eliza)

(defparameter +no-bindings+ '((T . T)))

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
  (block out
    (loop
     (print 'eliza-prompt>)
     (let* ((answer 
	     (flatten (use-eliza-rules (string->list (read-line)) :rules rules 
				       :preproc preproc))))
       (format t "~{~A ~}" answer)
       (if (member 'exit answer :test #'utils:eql-by-name-if-symbol)
	   (return-from out))))))
		   
(defun eliza (rules preproc)
  "Respond to user input using pattern matching rules."
  (interactive-interpreter
   :read #'read-line 
   :eval #'(lambda(x) 
	     (flatten (use-eliza-rules (string->list x) :rules rules 
				       :preproc preproc)))
   :print-prompt #'(lambda(x) (format t "~A" x))
   :print-eval #'(lambda(x) (format t "~{~A ~}~%" x))
   :exit #'(lambda(x y) 
	     (member x y :test #'utils:eql-by-name-if-symbol))
   :prompt (prompt-generator 0 "eliza [~d] > ")))
