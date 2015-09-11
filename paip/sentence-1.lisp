;;; Code from Paradigms of Artificial Intelligence Programming
;;; Copyright (c) 1991 Peter Norvig
;;; Website http://norvig.com/paip.html

(defun sentence ()    (append (noun-phrase) (verb-phrase)))
(defun noun-phrase () (append (article) (noun)))
(defun verb-phrase () (append (verb) (noun-phrase)))
(defun article ()     (one-of '(the a)))
(defun noun ()        (one-of '(man ball woman table)))
(defun verb ()        (one-of '(hit took saw liked)))


(defun adj* ()
  "problema!"
  (one-of '(nil (append (Adj) (Adj*)))))

(defun adj* ()
  "problema!"
  (one-of (list nil (append (Adj) (Adj*)))))

(defun adj* ()
  (if (= (random 2) 0)
      nil
      (append (Adj) (Adj*))))

(defun pp* ()
  (if (random-elt '(t nil))
      (append (PP) (PP*))
      nil))

(defun pp ()
  (append (Prep) (noun-phrase)))

(defun adj ()
  (one-of '(big little blue green adiabatic)))

(defun prep ()
  (one-of '(to in by with on)))

(defun noun-phrase ()
  (append (article) (adj*) (noun) (pp*)))



