(asdf:defsystem :cl-example
  :description "${PROJECT_DESCRIPTION}"
  :author "${AUTHOR_NAME} <${AUTHOR_EMAIL}>"
  :homepage "${PROJECT_WEBSITE}"

  :license "MIT"
  :version "0.0.1"

  :depends-on ()

  :in-order-to ((asdf:test-op (asdf:test-op :cl-example.test)))

  :serial t
  :components ((:file "package")
               (:module "src"
                :serial t
                :components ((:file "example")))))
