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

(define-easy-handler (analyze-photo :uri "/analyze-photo") (photo)
  (progn
    (my-copy-file photo "~/common-lisp/recycling/resources/images/raffi.jpg")
    (redirect "photo-results?photo=raffi.jpg"))
  )
