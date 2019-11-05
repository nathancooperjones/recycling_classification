(in-package :r-html)

(defun upload-photo-html ()
  (my-html `(:div
             ((:class "page-contents"))
             (:h1 "Check if the content of uploaded photo is recyclable")
             (:input ((:type "file") (:name "photo") (:accept "image/*")
                      ("required") (:id "photo-file")))
             (:a
              ((:onclick "uploadFile();")
               (:id "upload_file_button"))
              ,(feather-icon "upload"))
             (:img ((:id "upload-image") (:src "#")))))
  )
