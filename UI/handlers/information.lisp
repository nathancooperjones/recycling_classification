(in-package :r-handlers)

(define-easy-handler (Recycling-information :uri "/recycling-information") ()
  (recycling-information-html))
