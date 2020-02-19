;;;; recycling.asd

(asdf:defsystem #:recycling
  :description "Describe recycling here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (#:drakma #:krq-html #:hunchentoot
                             #:cl-json #:necessity)
  :components (
               (:module "html"
                :serial t
                :components
                ((:file "packages")
                 (:file "wrappers")
                 (:file "recycling-process")
                 (:file "recycling-facts")
                 (:file "upload-photo")
                 (:file "information")
                 (:file "mission")
                 (:file "results"))
                )
               (:module "handlers"
                :serial t
                :components
                ((:file "packages")
                 (:file "homepage")
                 (:file "save-photo")
                 (:file "analyze")
                 (:file "results")
                 (:file "information")
                 (:file "mission")))
               (:file "package")
               (:file "recycling")
               (:file "start-server")
               ))
