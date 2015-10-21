
;;  Author: Alexandre Rademaker
;;
;; For info why the dependencies file is necessary, read
;; http://weitz.de/packages.html

(asdf:defsystem #:paip
  :serial t
  :components ((:file "packages") 
	       (:file "utils"          :depends-on ("packages"))
	       (:file "sentence-1"     :depends-on ("utils"))
	       (:file "sentence-2"     :depends-on ("utils"))
	       (:file "gps-1"          :depends-on ("utils"))
	       (:file "gps-2"          :depends-on ("utils"))
	       (:file "gps-maze"       :depends-on ("gps-2"))
	       (:file "gps-school"     :depends-on ("gps-2"))
	       (:file "eliza"          :depends-on ("utils"))
	       (:file "eliza-english"  :depends-on ("eliza"))))

