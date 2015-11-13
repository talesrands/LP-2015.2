
(in-package test-pattern)

(deftest test-pat-match ()
 (check
  (equal (pat-match '(x = (?is ?n numberp)) '(x = 34)) '((?n . 34)))
  (equal (pat-match '(?x (?or < = >) ?y) '(3 < 4)) '((?y . 4) (?x . 3)))))

(deftest test-pattern ()
  (combine-results
    (test-pat-match)))
