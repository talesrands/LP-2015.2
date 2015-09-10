(defun sentence ()    (append (noun-phrase) (verb-phrase)))
(defun noun-phrase () (append (Noun) (Adj*)))
(defun verb-phrase () (append (Verb) (noun-phrase)))
(defun Article-masc ()     (one-of '(o um)))
(defun Article-fem ()     (one-of '(a uma)))
(defun Verb ()        (one-of '(viu elogiou abraçou traiu oprimiu ensinou idolatrou beijou)))
(defun Noun () 
  (if (= 0 (random 2)) (append (append (Article-masc)  (Noun-masc)) (Adj*-masc))
	 (append (append (Article-fem)  (Noun-fem)) (Adj*-fem))))
(defun one-of (set)
  "Pick one element of set, and make a list of it."
  (list (random-elt set)))

(defun random-elt (choices)
  "Choose an element from a list at random."
  (elt choices (random (length choices))))


(defun Adj*-fem () (if (= (random 2) 0)
			nil
			(append (Adj-fem) (Adj*-fem))))

(defun Adj*-masc () (if (= (random 2) 0)
			nil
			(append (Adj-masc) (Adj*-masc))))
			
(defun Adj-masc () (one-of '(grande pequeno azul verde feio bonito chato)))
(defun Adj-fem () (one-of '(grande pequena azul verde feia bonita chata)))

(defun Noun-masc () (one-of '(homem cachorro gato predador militar matematico engenheiro mendigo psicologo lucas leonardo rafael fellipe astronauta caio otavio secretario medico professor garçom advogado neymar alexandre)))
(defun Noun-fem () (one-of '(mulher cadela gata isabela secretaria esposa predadora engenheira psicologa medica professora kaline)))
