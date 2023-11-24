(asdf:defsystem :cl-${PROJECT_NAME}
  :description "${PROJECT_DESCRIPTION}"
  :author "${AUTHOR_NAME} <${AUTHOR_EMAIL}>"
  :homepage "${PROJECT_WEBSITE}"

  :license "MIT"
  :version "0.0.1"

  :depends-on ()

  :in-order-to ((asdf:test-op (asdf:test-op :cl-${PROJECT_NAME}.test)))

  :serial t
  :components ((:file "package")
               (:module "src"
                :serial t
                :components ((:file "${PROJECT_NAME}")))))
