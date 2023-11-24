(ql:quickload 'cl-${PROJECT_NAME}.test :silent t)
(time (asdf:test-system 'cl-${PROJECT_NAME}))
(quit)
