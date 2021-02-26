(import ../src/testament)

(comment

  (let [_ (testament/reset-tests!)
        output @""
        stats
        ``
        1 tests run containing 1 assertions
        1 tests passed, 0 tests failed
        ``
        len (->> (string/split "\n" stats)
                 (map length)
                 splice
                 max)
        rule (string/repeat "-" len)]
    (with-dyns [:out output]
      (testament/exercise! []
                           (testament/deftest test-name
                                              (testament/assert-equal 1 1))))
    (= (string "\n"
               rule "\n"
               stats "\n"
               rule "\n")
       (string output)))
  # => true

  (defer (testament/reset-tests!)
    (let [output @""]
      (with-dyns [:out output]
        (testament/exercise! [:silent true]
                             (testament/deftest test-name
                                                (testament/assert-equal 1 1))))
    output))
  # => @""

  )
