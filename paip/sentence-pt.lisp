(defun sentence ()    (append (noun-phrase) (verb-phrase)))
(defun noun-phrase () (append (Noun) (Adj*)))
(defun verb-phrase () (append (Verb) (noun-phrase)))
(defun Article-masc ()     (one-of '(o um)))
(defun Article-fem ()     (one-of '(a uma)))
(defun Verb ()        (one-of '(viu elogiou abraçou beijou)))
(defun Noun () 
  (if (= 0 (random 2)) (append (Article-masc)  (Noun-masc))
	 (append (Article-fem)  (Noun-fem))))
(defun one-of (set)
  "Pick one element of set, and make a list of it."
  (list (random-elt set)))

(defun random-elt (choices)
  "Choose an element from a list at random."
  (elt choices (random (length choices))))


(defun Adj* () (if (= (random 2) 0)
		   nil
		   (append (Adj) (Adj*))))
(defun Adj () (one-of '(grande pequeno azul verde feio bonito chato)))

(defun Noun-masc () (one-of '(homem cachorro gato predador militar matematico engenheiro mendigo)))
(defun Noun-fem () (one-of '(mulher cadela gata predadora engenheira psicologa medica)))
