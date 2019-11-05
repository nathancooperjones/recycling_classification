(defpackage #:r-html
  (:use :cl #:krq-html #:split-sequence #:alexandria #:drakma #:cl-json)
  (:export #:my-html #:upload-photo-html #:recycling-information-html
           #:mission-statement-html #:photo-results-html)
  )

(in-package :r-html)
