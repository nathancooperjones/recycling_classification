(in-package :r-handlers)

(defun my-copy-file (from-file to-file)
  "Copy file of the from-path to the to-path"
  (with-open-file (input-stream from-file
                                :direction :input
                                :element-type '(unsigned-byte 8))
    (with-open-file (output-stream to-file
                                   :direction :output
                                   :if-exists :supersede
                                   :if-does-not-exist :create
                                   :element-type '(unsigned-byte 8))
      (let ((buf (make-array 4096 :element-type (stream-element-type input-stream))))
        (loop for pos = (read-sequence buf input-stream)
              while (plusp pos)
              do (write-sequence buf output-stream :end pos))))))

;; (define-easy-handler (save-photo :uri "/save-photo") (data)
;;   (if data
;;       (progn
;;         (log-message* :info "~a" data)
;;         (my-copy-file data "~/data/recycling/images/bulb.jpg")
;;         )
;;       (html
;;        `(:p "data not uploaded"))
;;       )
;;   )

(defparameter *local-photo-upload-path*
  "~/common-lisp/recycling/recycling_classification/UI/resources/images/")

(defun generate-random-id ()
  (random (expt 2 63)))

(defun see-if-photo-id-exists (id)
  (let ((path (cat *local-photo-upload-path* id ".jpg")))
    (when (probe-file path)
        't)))

(defun generate-unique-id ()
  (let ((id (generate-random-id)))
    (if (see-if-photo-id-exists id)
        (generate-unique-id)
        id)))

(defun generate-photo-path (id)
  (cat *local-photo-upload-path* id ".jpg"))

(defun save-photo-id (photo-path id)
  (my-copy-file photo-path (generate-photo-path id)))

(define-easy-handler
    (upload-photo-handler :uri "/save-photo"  :default-request-type :post)
    (photo)
  (let ((photo-path (car photo))
        (photo-name (cadr photo))
        (photo-type (caddr photo))
        (id (generate-unique-id)))
    (progn
      (log-message* :info "~a" photo)
      (log-message* :info "~a" photo-path)
      (log-message* :info "~a" photo-name)
      (log-message* :info "~a" photo-type)
      (save-photo-id photo-path id)
      (redirect (cat "/photo-results?photo-id=" id ".jpg"))
      )
    )
  )
