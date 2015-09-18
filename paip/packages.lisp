
(defpackage :utils
  (:use :cl)
  (:export
   #:one-of
   #:random-elt
   #:cross-product
   #:mappend
   #:combine-all))

(defpackage :chapter-1
  (:use :utils :cl)
  (:export
   #:generate))




