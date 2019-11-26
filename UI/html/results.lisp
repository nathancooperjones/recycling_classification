(in-package :r-html)

;; (defun photo-results-html (photo-path)
;;   (my-html `(:div
;;              ((:class "page-contents-results"))
;;              ,(results-maker photo-path)
;;              (:img ((:id "uploaded-image") (:src "resources/images/",photo-path)))))
;;   )

(defun photo-classified-html (photo-path)
  (let ((class (filler-class-choice)))
    (my-html
     `(:div
       ((:class "page-contents-results"))
       (:div
        ((:class "photo-analysis-image-results"))
        (:div
         ((:class "photo-analysis-results"))
         ,(filler-class-results class))
        (:img ((:id "uploaded-image") (:src "resources/images/",photo-path))))
       (:div
        ((:class "photo-analysis-results-info"))
        (:div
         ((:class "recycling-process"))
         (:h2 "Recycling Process")
         ,(classes-recycling-process class 90))
        (:div
         ((:class "recycling-information"))
         (:h2 "Fun Facts")
         ,(classes-recycling-facts class))
        )
       )
     ))
  )

(defun photo-classified-html (photo-path)
  (let* ((json (http-request-json (ai-analysis-url (cat photo-path))))
         (class (get-class-from-json json))
         (probability (get-probability-from-json json)))
    (my-html
     `(:div
       ((:class "page-contents-results"))
       (:div
        ((:class "photo-analysis-image-results"))
        (:div
         ((:class "photo-analysis-results"))
         ,(photo-analysis-results class probability))
        (:img ((:id "uploaded-image") (:src "resources/images/",photo-path))))
       (:div
        ((:class "photo-analysis-results-info"))
        (:div
         ((:class "recycling-process"))
         (:h2 "Recycling Process")
         ,(classes-recycling-process class probability))
        (:div
         ((:class "recycling-information"))
         (:h2 "Fun Facts")
         ,(classes-recycling-process class probability))
        )
       )
     ))
  )

(defun filler-percentage ()
  (let ((number (random 8)))
    (if (< number 7)
        80
        60)))

(defun filler-class-choice ()
  (let ((number (random 8)))
    (cond
      ((equal number 0)
       "metals")
      ((equal number 1)
       "paper-cardboard")
      ((equal number 2)
       "glass")
      ((equal number 3)
       "plastics")
      ((equal number 4)
       "bulbs")
      ((equal number 5)
       "electronics")
      ((equal number 6)
       "batteries")
      ((equal number 7)
       "unclassified")
      )
    )
  )

(defun filler-class-results (class)
  (json-analysis-results (json-file-tester class))
  )

(defparameter *analyze-photo-url-base*
  "http://3.134.39.167/predict_recylable_from_image_url?url=https://noahquanrud.com/recycling/resources/images/")

(defun ai-analysis-url (photo-path)
  (cat *analyze-photo-url-base* photo-path))

(defun results-classes (class)
  (cond
    ((equal class "metals")
     "Metal")
    ((equal class "paper-cardboard")
     "Paper or Cardboard")
    ((equal class "glass")
     "Glass")
    ((equal class "plastics")
     "Plastics")
    ((equal class "bulbs")
     "Bulbs")
    ((equal class "electronics")
     "Electronics")
    ((equal class "batteries")
     "Batteries")
    )
  )

(defun json-analysis-results (json)
  (let ((class (get-class-from-json json))
        (probability (get-probability-from-json json)))
   (photo-analysis-results class probability)))

(defun photo-analysis-results (class probability)
  (cond
    ((> probability 55)
     `(:div
       ((:class "recyclable-result"))
       (:div ((:class "recyclable-classification")) (:p "Recyclable"))
       (:div ((:class "recyclable-confidence"))
             (:p "Classified under "
                 (:b ,(results-classes class)) " with "
                 ,(format-probability probability) "% confidence")))
     )
    ('t
     `(:div
       ((:class "recyclable-result"))
       (:div ((:class "recyclable-classification")) "Unclassified")
       (:div ((:class "recyclable-confidence"))
             (:p "Not confident enough to give classification"))))
    )
  )

(defun get-class-from-json (json)
  (cdr (find :class json :test #'equal :key #'car)))

(defun format-probability (probability)
  (format nil "~1$" probability))

(defun get-probability-from-json (json)
  (* 100 (cdr (find :probability json :test #'equal :key #'car))))

(defun classify-photo-url (url)
  (let ((class (get-class-from-json (http-request-json url))))
    (results-classes class)))

(defun http-request-json (url)
  (with-open-stream (stream (http-request url
                                          :accept "application/json"
                                          :content-type "application/json"
                                          :external-format-out :utf-8
                                          :external-format-in :utf-8
                                          :want-stream t))
    (cl-json:decode-json-from-source
     stream)))

(defun json-file-tester (class)
  (with-open-file
      (stream
       (cat
        "~/common-lisp/recycling/recycling_classification/ui/resources/testing/"
        class
        ".json"))
    (cl-json:decode-json-from-source stream)))

;; (http-request-json
;;  "http://3.134.39.167/predict_recylable_from_image_url?url=https://noahquanrud.com/recycling/resources/images/metal.jpg"
;;  )

;; (classify-photo-url
;;  "http://3.134.39.167/predict_recylable_from_image_url?url=https://noahquanrud.com/recycling/resources/images/metal.jpg")

;; (get-probability-from-json
;;  (with-open-file
;;      (stream
;;       "~/common-lisp/recycling/recycling_classification/ui/resources/testing/ex.json")
;;    (cl-json:decode-json-from-source stream)))

;; (defun metal-subcategories (subcategory)
;;   (cond
;;     ((equal subcategory "Aluminum Cans")
;;      `(:p "Subcategory is Aluminum Cans"))
;;     ((equal subcategory "Aluminum Foil")
;;      `(:p "Subcategory is Aluminum Foil"))
;;     ((equal subcategory "Bakeware")
;;      `(:p "Subcategory is Bakeware"))
;;     ((equal subcategory "Steel Cans")
;;      `(:p "Subcategory is Steel Cans"))
;;     ((equal subcategory "Tin Cans")
;;      `(:p "Subcategory is Tin Cans"))
;;     )
;;   )

;; (defun paper-cardboard-subcategories (subcategory)
;;   (cond
;;     ((equal subcategory "Currogated Cardboard")
;;      `(:p "Subcategory is Currogated Cardboard"))
;;     ((equal subcategory "Magazines")
;;      `(:p "Subcategory is Magazines"))
;;     ((equal subcategory "Office Paper")
;;      `(:p "Subcategory is Office Paper"))
;;     ((equal subcategory "Newspaper")
;;      `(:p "Subcategory is Newspaper"))
;;     ((equal subcategory "Paperboard")
;;      `(:p "Subcategory is Paperboard"))
;;     ((equal subcategory "Cartons")
;;      `(:p "Subcategory is Cartons"))
;;     ((equal subcategory "Mail")
;;      `(:p "Subcategory is Mail"))
;;     ((equal subcategory "Phone Books")
;;      `(:p "Subcategory is Phone Books"))
;;     )
;;   )

;; (defun glass-subcategories (subcategory)
;;   (cond
;;     ((equal subcategory "Clear Glass")
;;      `(:p "Subcategory is Clear Glass"))
;;     ((equal subcategory "Brown Glass")
;;      `(:p "Subcategory is Brown Glass"))
;;     ((equal subcategory "Green Glass")
;;      `(:p "Subcategory is Green Glass"))
;;     )
;;   )

;; (defun plastics-subcategories (subcategory)
;;   (cond
;;     ((equal subcategory "Plastics")
;;      `(:p "Subcategory is Plastics"))
;;     )
;;   )

;; (defun Batteries-subcategories (subcategory)
;;   (cond
;;     ((equal subcategory "Car Battery")
;;      `(:p "Subcategory is Clear Glass"))
;;     ((equal subcategory "Household Battery")
;;      `(:p "Subcategory is Household Battery"))
;;     ((equal subcategory "Rechargeable Battery")
;;      `(:p "Subcategory is Rechargeable Battery"))
;;     )
;;   )

;; (defun Bulbs-subcategories (subcategory)
;;   (cond
;;     ((equal subcategory "Incandescent and LED")
;;      `(:p "Subcategory is Incandescent and LED"))
;;     ((equal subcategory "Compact Flourescent Bulbs")
;;      `(:p "Subcategory is Compact Flourescent Bulbs"))
;;     ((equal subcategory "Light Bulbs")
;;      `(:p "Subcategory is Light Bulbs"))
;;     ((equal subcategory "Cathode Ray Tubes")
;;      `(:p "Subcategory is Cathode Ray Tubes"))
;;     )
;;   )
