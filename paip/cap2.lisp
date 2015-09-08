
(defun sentence ()  (append (noun-phrase) (verb-phrase)))
(defun noun-phrase () (append (Article) (Noun)))
(defun verb-phrase () (append (Verb) (noun-phrase)))
(defun Article ()  (one-of '(the a)))
(defun Noun ()  (one-of '(man ball woman table)))
(defun Verb ()  (one-of '(hit took saw liked)))

(defun one-of (set)
  (list (random-elt set)))

(defun random-elt (choices)
  (elt choices (random (length choices))))


(defun Adj* ()
  (if (= (random 2) 0)
      nil
      (append (Adj) (Adj*))))

(defun PP* ()
  (if (random-elt '(t nil))
      (append (PP) (PP*))
      nil))

(defun noun-phrase () (append (Article) (Adj*) (Noun) (PP*)))
(defun PP () (append (Prep) (noun-phrase)))
(defun Adj () (one-of '(big little blue green adiabatic)))
(defun Prep () (one-of '(big little blue green adiabatic)))
(defun Prep () (one-of '(to in by with on)))


(defparameter *simple-grammar*
  '((sentence -> (noun-phrase verb-phrase))
    (noun-phrase -> (Article Noun))
    (verb-phrase -> (Verb noun-phrase))
    (Article -> the a)
    (Noun -> man ball woman table)
    (Verb -> hit took saw liked))
  "A grammar for a trivial subset of English.")


(defvar *grammar* *simple-grammar*
  "The grammar used by generate.")
