
(in-package test-search)

(deftest test-depth-first-search ()
  (check
    (equal (depth-first-search 1 (is 16) (finite-binary-tree 15)) nil)
    (equal (depth-first-search 1 (is 13) (finite-binary-tree 15)) 13)
    (equal (depth-first-search 1 (is 12) (finite-binary-tree 15)) 12)))

(deftest test-breadth-first-search ()
  (check
    (equal (breadth-first-search 1 (is 12) 'binary-tree) 12)))

(deftest test-search ()
  (combine-results
    (test-depth-first-search)
    (test-breadth-first-search)))
