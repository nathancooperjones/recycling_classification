(in-package #:recycling)

(defparameter *resources-path*
  "~/common-lisp/recycling/recycling_classification/UI/resources/")

(defvar *acceptor* nil)

(defun make-keyword (name) (values (intern (string-upcase name) :keyword)))

(defun start-server-recycling (&key (resource-path *resources-path*))
  (unless *acceptor*
    (setf *acceptor* (Make-Instance 'hunchentoot:easy-acceptor :port 4973))
    (hunchentoot:start *acceptor*)
    (push (hunchentoot:create-folder-dispatcher-and-handler
           "/resources/"
           resource-path
           )
          hunchentoot:*dispatch-table*))
  )

(when nil
  (sb-thread:make-thread #'start-server-recycling)
  )

(defun file-get-lines (filename)
  (with-open-file (stream filename)
    (loop for line = (read-line stream nil)
          while line
          collect line)))

(defun file-get-contents (filename)
  (with-open-file (stream filename)
    (let ((contents (make-string (file-length stream))))
      (read-sequence contents stream)
      contents)))
