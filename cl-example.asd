(asdf:defsystem :cl-example
  :description "Example Common Lisp project"
  :author "John McCarthy <john@example.com>"
  :homepage "https://www.gnu.org/software/emacs/"

  :license "MIT"
  :version "0.0.1"

  :depends-on ()

  :in-order-to ((asdf:test-op (asdf:test-op :cl-example.test)))

  :serial t
  :components ((:file "package")
               (:module "src"
                :serial t
                :components ((:file "example")))))
