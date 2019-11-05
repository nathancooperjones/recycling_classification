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

(defun results-classes (class)
  (cond
    ((equal class "Metals")
     `(:p "Classified as metal"))
    ((equal class "Paper/Cardboard")
     `(:p "Classified as paper or cardboard"))
    ((equal class "Glass")
     `(:p "Classified as glass"))
    ((equal class "Plastics")
     `(:p "Classified as plastics"))
    ((equal class "Bulbs")
     `(:p "Classified as bulbs"))
    ((equal class "Electronics")
     `(:p "Classified as electronics"))
    ((equal class "Batteries")
     `(:p "Classified as batteries"))
    ('t
     `(:p "Classified as non-recyclable"))
    )
  )

;; (http-request-json
;;  "https://stats.nba.com/stats/commonteamroster?LeagueID=00&Season=2017-18&TeamID=1610612756")

(defun http-request-json (url)
  (with-open-stream (stream (http-request url
                                          :accept "application/json"
                                          :content-type "application/json"
                                          :external-format-out :utf-8
                                          :external-format-in :utf-8
                                          :want-stream t))
    (cl-json:decode-json-from-source
     stream)))

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
