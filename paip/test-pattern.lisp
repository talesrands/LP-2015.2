(in package test-search)

(deftest test-pat-match ()
 (check
  (equal (pat-match '(x = (?is ?n numberp)) '(x = 34)) '((?n . 34)))
  (equal (pat-match '(?x (?or < = >) ?y) '(3 < 4)) '((?y . 4) (?x . 3)))))
