(import ../src/testament)

(comment

  (defer (testament/reset-tests!)
    (testament/deftest test-name :noop)
    (type test-name))
  # => :function

  (defer (testament/reset-tests!)
    (def anon-test (testament/deftest :noop))
    (type anon-test))
  # => :function

  )
