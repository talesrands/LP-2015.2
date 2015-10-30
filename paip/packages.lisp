
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
   #:eql-by-name-if-symbol))

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

(defpackage :eliza
  (:use :cl :utils)
  (:export
   #:eliza))

(defpackage :eliza-test
  (:use :cl :utils :eliza))
