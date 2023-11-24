(asdf:defsystem :cl-example.test
  :description "Test suite for cl-example"

  :author "Petar Radosevic <petar@petar.dev>"
  :license "MIT"

  :depends-on (:cl-example
               :1am)

  :serial t
  :components ((:file "package.test")
               (:module "test"
                :serial t
                :components ((:file "tests"))))

  :perform (asdf:test-op
             (op system)
             (uiop:symbol-call :example.test :run-tests)))
