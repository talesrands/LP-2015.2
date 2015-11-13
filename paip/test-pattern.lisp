(in package test-search)

(deftest test-pat-match ()
 (check
  (equal (pat-match '(x = (?is ?n numberp)) '(x = 34)) '((?n . 34)))))
