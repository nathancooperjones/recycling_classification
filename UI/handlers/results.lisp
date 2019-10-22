(in-package :r-handlers)

(define-easy-handler (Recycling-photo-results :uri "/photo-results") (photo)
  (photo-results-html photo))
