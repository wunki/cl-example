(asdf:defsystem :cl-${PROJECT_NAME}.test
  :description "Test suite for ${PROJECT_NAME}"

  :author "${AUTHOR_NAME} <${AUTHOR_EMAIL}>"
  :license "MIT"

  :depends-on (:cl-${PROJECT_NAME}
               :1am)

  :serial t
  :components ((:file "package.test")
               (:module "test"
                :serial t
                :components ((:file "tests"))))

  :perform (asdf:test-op
             (op system)
             (uiop:symbol-call :${PROJECT_NAME}.test :run-tests)))
