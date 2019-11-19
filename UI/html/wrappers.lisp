(in-package :r-html)

(defun feather-icon (name)
  `(:i (("data-feather",name)) nil)
  )

(defun my-html (x)
  (html
   `(:html
     (:head
      (:meta
       ((:name :viewport)
        (:content
         "width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no")))
      (:link ((:rel :stylesheet) (:href "resources/rc.css")))
      ;; (:link ((:rel :stylesheet) (:href "/resources/experimental/2019-09-01.css")))
      )
     (:body
      (:div
       ((:class "container internal"))
       ,(header-bar)
       ,x
       )
      (:footer
       (:script
        ((:src "https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"))
        nil)
       ;(:script ((:src "resources/upload-photo.js")) nil)
       (:script ((:src "resources/feather.js")) nil)
       (:script "feather.replace()"))))))


(defun header-bar ()
  `(:div ((:class "header-bar"))
         (:a ((:href "recycling-upload-photo")) "Upload Photo")
         (:a ((:href "recycling-information")) "Recycling Information")
         (:a ((:href "mission-statement")) "Mission Statement")))
