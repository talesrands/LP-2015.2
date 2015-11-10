
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
   #:+fail+))

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
   #:use))

(defpackage :gps-test
  (:use :utils :cl :gps-2))

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
   #:segment-pattern-p))

(defpackage :eliza
  (:use :cl :utils :pattern)
  (:export
   #:eliza))

(defpackage :eliza-test
  (:use :cl :utils :eliza))

(defpackage :search
  (:use :cl :utils))
