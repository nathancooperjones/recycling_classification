(in-package :r-handlers)

(define-easy-handler (Recycling-mission-statement :uri "/mission-statement") ()
  (mission-statement-html))
