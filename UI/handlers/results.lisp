(in-package :r-handlers)

(define-easy-handler (Recycling-photo-results :uri "/photo-results") (photo-id)
  (photo-classified-html photo-id))
