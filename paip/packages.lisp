
(defpackage :utils
  (:use :cl)
  (:export
   #:one-of
   #:random-elt
   #:cross-product
   #:mappend
   #:combine-all
   #:find-all
   #:find-all-if
   #:dbg
   #:debug-on
   #:debug-off
   #:dbg-indent
   #:starts-with
   #:flatten
   #:string->list
   #:eql-by-name-if-symbol
   #:interactive-interpreter
   #:prompt-generator
   #:rule-based-translator))

(defpackage :chapter-1
  (:use :utils :cl)
  (:export
   #:generate
   #:*grammar*))

(defpackage :gps-1
  (:use :utils :cl))

(defpackage :gps-2
  (:use :utils :cl)
  (:export
   #:op
   #:make-op
   #:op-add-list
   #:op-del-list
   #:op-preconds
   #:op-action
   #:gps
   #:use
   #:*ops*
   #:action-p
   #:member-equal))

(defpackage :tests-framework
  (:use :utils :cl)
  (:export
   #:deftest
   #:combine-results
   #:with-gensyms
   #:check
   #:report-result))

(defpackage :search
  (:use :cl :utils)
  (:export
   #:tree-search
   #:depth-first-search
   #:binary-tree
   #:is
   #:prepend
   #:breadth-first-search
   #:finite-binary-tree
   #:diff
   #:best-first-search
   #:beam-search))

(defpackage :search-test
  (:use :utils :cl :search :tests-framework))

(defpackage :gps-search
  (:use :utils :cl :search)
  (:export
   #:gps-search))

(defpackage :gps-test
  (:use :utils :cl :gps-2 :gps-search))

(defpackage :pattern
  (:use :cl :utils)
  (:export
   #:variable-p
   #:make-binding
   #:binding-var
   #:binding-val
   #:get-binding
   #:lookup
   #:extend-bindings
   #:match-variable
   #:pat-match
   #:pat-match-abbrev
   #:segment-pattern-p
   #:expand-pat-match-abbrev))

(defpackage :pattern-test
  (:use :utils :cl :pattern :tests-framework))


(defpackage :eliza
  (:use :cl :utils :pattern)
  (:export
   #:eliza))

(defpackage :eliza-test
  (:use :cl :utils :eliza :pattern))

(defpackage :student
  (:use :utils :cl :pattern))

(defpackage :clos
  (:use :cl :utils))
