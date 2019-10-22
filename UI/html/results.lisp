(in-package :r-html)

(defun photo-results-html (photo)
  (my-html `(:div
             ((:class "page-contents-results"))
             ,(results-maker photo)
             (:img ((:id "uploaded-image") (:src "resources/images/",photo)))))
  )

(defun results-maker (photo)
  (let ((name (car (split-sequence:split-sequence #\. photo))))
    (if (equal "raffi" name)
        `(:div ((:class "trash-results")) "Non-Recyclable")
        `(:div ((:class "recyclable-results")) "Recyclable"))))
