(in-package :r-html)

;; (defun upload-photo-html ()
;;   (my-html `(:div
;;              ((:class "page-contents"))
;;              (:h1 "Check if the content of uploaded photo is recyclable")
;;              (:input
;;               ((:type "file") ("required") (:accept "image/*"))
;;               (:br))
;;              (:a
;;               ((:onclick "uploadFile();")
;;                (:id "upload_file_button"))
;;               ,(feather-icon "upload"))
;;              (:img ((:id "upload-image") (:src "#") (:id "photo-file")))))
;;   )

(defun upload-photo-html ()
  (my-html
   `(:div
     ((:class "page-contents"))
     (:h1 "Check if the content of uploaded photo is recyclable")
     (:form
      ((:action "save-photo") (:method "post")
       (:enctype "multipart/form-data"))
      (:input
       ((:type "file") (:name "photo") (:accept "image/*")
        ("required") (:id "photo")))
      (:input ((:type "submit")))
            )
     )
   )
  )
