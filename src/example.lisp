(in-package :example)

(defun read-file (filename)
  "Reads the contents of FILENAME into a string."
  (with-open-file (stream filename)
    (let ((contents (make-string (file-length stream))))
      (read-sequence contents stream)
      contents)))
