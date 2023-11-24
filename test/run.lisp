(ql:quickload 'cl-example.test :silent t)
(time (asdf:test-system 'cl-example))
(quit)
