(defpackage #:r-html
  (:use :cl #:hunchentoot #:krq-html #:split-sequence #:alexandria)
  (:export #:my-html #:upload-photo-html #:recycling-information-html
           #:mission-statement-html #:photo-results-html)
  )

(in-package :r-html)
