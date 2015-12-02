
(in-package :pattern-test)

(deftest test-pat-match ()
 (check
  (equal (nth-value 1 (pat-match '(x = (?is ?n numberp)) '(x = 34))) '((?n . 34)))
  (equal (nth-value 1 (pat-match '(?x (?or < = >) ?y) '(3 < 4))) '((?y . 4) (?x . 3)))
  (multiple-value-bind (res binding) (pat-match '(teste ?x com (?* ?y) da função (?or pat-match segment-match)) '(teste preliminar com algumas funcionalidades da função segment-match)) (and res (equal binding '((?Y algumas funcionalidades) (?X . preliminar)))))
  (multiple-value-bind (res binding) (pat-match '(a (?* ?x) c d) '(a b c b c d)) (and res (equal binding '((?X B C B)))))
  (multiple-value-bind (res binding) (pat-match '(até (?* ?X) mas) '(até funcionaria porém)) (and (not res) (not binding)))))
  
(deftest test-pattern ()
  (combine-results
    (test-pat-match)))
