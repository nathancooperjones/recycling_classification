(in-package :r-handlers)

(define-easy-handler (Recycling-upload-file :uri "/recycling-upload-photo") ()
  (upload-photo-html))
