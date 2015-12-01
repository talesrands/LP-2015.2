
(in-package :pattern-test)

(deftest test-pat-match ()
 (check
  (equal (nth-value 1 (pat-match '(x = (?is ?n numberp)) '(x = 34))) '((?n . 34)))
  (equal (nth-value 1 (pat-match '(?x (?or < = >) ?y) '(3 < 4))) '((?y . 4) (?x . 3)))))

(deftest test-pattern ()
  (combine-results
    (test-pat-match)))
