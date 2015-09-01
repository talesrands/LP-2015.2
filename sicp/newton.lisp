
(defun good-enough? (guess x)
  (< (abs (- (* guess guess) x)) 0.001))

(defun average (x y)
  (/ (+ x y) 2))

(defun improve (guess x)
  (average guess (/ x guess)))

(defun sqrt-iter (guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
		 x)))

(defun my-sqrt (x)
  (sqrt-iter 1.0 x))
  
;;					Exercício 1.7 - Início:

(defun good-enough?1.7(previous-guess guess)
;;Compara se o guess e o previous-guess estão suficientemente próximos
  (if (< (abs (- guess previous-guess)) 0.001)
      t
      nil
      )
  )

(defun sqrt-iter1.7(previous-guess guess x)
;;Melhora o guess até ele ficar bom o suficiente.
  (if (good-enough?1.7 previous-guess  guess)
      guess
      (sqrt-iter1.7 guess (improve guess x) x)))

(defun my-sqrt1.7(x)
;;Atribui 0 para o previous-guess e 1 para o guess (abs 1 - 0) > 0.001 e chama sqrt-iter1.7
  (sqrt-iter1.7 0.0 1.0 x))


					;;Exercício 1.7 FIM
					
					;;Exercício 1.8 Início
(defun improve-cube(y x)
  (/ ( + (/ x (* y y)) (* 2 y)) 3))

(defun cubo(x)
  (* x (* x x))
  )
   
(defun good-enough-cube? (guess x)
  (if (< (abs (- x (cubo guess ))) 0.001)
      t
      nil
      )
  )
(defun cube-root-iter(guess x)
  (if (good-enough-cube? guess x) 
      guess
      (cube-root-iter (improve-cube guess x) x)
      )
  )
  
(defun cube-root (x)
  (cube-root-iter 1.0 x)
  )
				
					;;Exercício 1.8 - FIM


;; to test
;; http://malisper.me/2015/08/19/debugging-lisp-part-5-miscellaneous/

