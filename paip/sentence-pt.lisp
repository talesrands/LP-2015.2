(defun sentence () (append (noun-phrase) (verb-phrase)))
(defun noun-phrase () (append (Noun)))
(defun verb-phrase () (append (Verb) (noun-phrase)))
(defun Article-masc () (one-of '(o um)))
(defun Article-fem () (one-of '(a uma)))
(defun Verb () (one-of '(viu elogiou abraçou traiu oprimiu ensinou idolatrou beijou)))

(defun Noun () 
  (if (= 0 (random 2)) (append (Article-masc)  (Noun-masc) (Adj*-masc))
      (append (Article-fem) (Noun-fem) (Adj*-fem))))

(defun one-of (set)
  "Pick one element of set, and make a list of it."
  (list (random-elt set)))

(defun random-elt (choices)
  "Choose an element from a list at random."
  (elt choices (random (length choices))))


(defun Adj*-fem () 
  (if (= (random 2) 0)
      nil
      (append (Adj-fem) (Adj*-fem))))

(defun Adj*-masc ()
  (if (= (random 2) 0)
      nil
      (append (Adj-masc) (Adj*-masc))))

(defun Adj-masc () (one-of '(grande pequeno azul verde feio bonito chato)))

(defun Adj-fem () (one-of '(grande pequena azul verde feia bonita chata)))

(defun Noun-masc () (one-of '(homem cachorro gato predador militar matematico engenheiro mendigo psicologo lucas leonardo rafael fellipe astronauta caio otavio secretario medico professor garçom advogado neymar alexandre)))

(defun Noun-fem () (one-of '(mulher cadela gata isabela secretaria esposa predadora engenheira psicologa medica professora kaline)))

(defparameter *simple-grammar*
  '((sentence -> (noun-phrase verb-phrase))
    (noun-phrase -> (Article Noun))
    (verb-phrase -> (Verb noun-phrase))
    (Article -> o a um uma)
    (Noun -> menino homem)
    (Verb -> abraçou empurrou)))

(defparameter *grammar-pt*
   '((sentence -> (noun-phrase verb-phrase))
     (noun-phrase -> masculino feminino)
     (masculino -> (Article-masculino Noun-masculino))
     (feminino -> (Article-feminino Noun-feminino))
     (verb-phrase -> (Verb noun-phrase))
     (Article-masculino -> o um)
     (Noun-masculino -> homem menino rapaz)
     (Article-feminino -> a uma)
     (Noun-feminino -> mulher menina garota)
     (Verb -> abraçou empurrou)))

(defvar *grammar* *grammar-pt* "Thegrammarusedbygenerate. Initially,thisis *grammar-pt*, but we can switch to other grammars.")

(defun rule-lhs (rule)
  "The left-hand side of a rule."
  (first rule))

(defun rule-rhs (rule)
  "The right-hand side of a rule."
  (rest (rest rule)))

(defun rewrites (category)
  "Return a list of the possible rewrites for this category."
  (rule-rhs (assoc category *grammar*)))

(defun generate (phrase)
  "Generate a random sentence or phrase"
  (if (listp phrase)
      (mappend #'generate phrase)
      (let ((choices (rewrites phrase)))
	(if (null choices) (list phrase)
	    (generate (random-elt choices))))))


(defun mappend (fn the-list)
  "Apply fn t o each element of list and append the results."
  (apply #'append (mapcar fn the-list)))

(defun random-elt (choices)
  (elt choices (random (length choices))))
