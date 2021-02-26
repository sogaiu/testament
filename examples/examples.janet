(import ../src/testament)

(comment

  (testament/== [@[{:a 1}]]
                @[[@{:a 1}]])
  # => true

  (defer (testament/reset-tests!)
    (testament/deftest test-name :noop)
    (type test-name))
  # => :function

  (defer (testament/reset-tests!)
    (def anon-test (testament/deftest :noop))
    (type anon-test))
  # => :function

  (deep=
    #
    (testament/assert-expr 1)
    #
    {:kind    :expr
     :passed? true
     :expect  true
     :actual  true
     :note    "1"})
  # => true

  (deep=
    #
    (testament/assert-equal 1 1)
    #
    {:kind    :equal
     :passed? true
     :expect  1
     :actual  1
     :note    "(= 1 1)"})
  # => true

  (deep=
    #
    (testament/assert-deep-equal @[1] @[1])
    #
    {:kind    :equal
     :passed? true
     :expect  @[1]
     :actual  @[1]
     :note    "(deep= @[1] @[1])"})
  # => true

  (deep=
    #
    (testament/assert-equivalent [1] @[1])
    #
    {:kind    :equal
     :passed? true
     :expect  [1]
     :actual  @[1]
     :note    "(== [1] @[1])"})
  # => true

  (deep=
    #
    (testament/assert-matches {:a _} {:a 10})
    #
    {:kind    :matches
     :passed? true
     :expect  {:a '_}
     :actual  {:a 10}
     :note    "(matches {:a _} {:a 10})"})
  # => true

  (deep=
    #
    (testament/assert-thrown (error "An error"))
    #
    {:kind    :thrown
     :passed? true
     :expect  true
     :actual  true
     :note    "thrown? (error \"An error\")"})
  # => true

  (deep=
    #
    (testament/assert-thrown-message "An error" (error "An error"))
    #
    {:kind    :thrown-message
     :passed? true
     :expect  "An error"
     :actual  "An error"
     :note    "thrown? \"An error\" (error \"An error\")"})
  # => true

  (deep=
    #
    (testament/is 1)
    #
    {:kind    :expr
     :passed? true
     :expect  true
     :actual  true
     :note    "1"})
  # => true

  (deep=
    #
    (testament/is (= 1 2))
    #
    {:kind    :equal
     :passed? false
     :expect  1
     :actual  2
     :note    "(= 1 2)"})
  # => true

  (deep=
    #
    (testament/is (deep= @[1] @[2]))
    #
    {:kind    :equal
     :passed? false
     :expect  @[1]
     :actual  @[2]
     :note    "(deep= @[1] @[2])"})
  # => true

  (deep=
    #
    (testament/is (== [1] @[2]))
    #
    {:kind    :equal
     :passed? false
     :expect  [1]
     :actual  @[2]
     :note    "(== [1] @[2])"})
  # => true

  (deep=
    #
    (testament/is (matches {:b _} {:a 10}))
    #
    {:kind    :matches
     :passed? false
     :expect  {:b '_}
     :actual  {:a 10}
     :note    "(matches {:b _} {:a 10})"})
  # => true

  (deep=
    #
    (testament/is (thrown? (error "An error")))
    #
    {:kind    :thrown
     :passed? true
     :expect  true
     :actual  true
     :note    "thrown? (error \"An error\")"})
  # => true

  (deep=
    #
    (testament/is (thrown? "An error" (error "An error")))
    #
    {:kind    :thrown-message
     :passed? true
     :expect  "An error"
     :actual  "An error"
     :note    "thrown? \"An error\" (error \"An error\")"})
  # => true

  (deep=
    #
    (defer (testament/reset-tests!)
      (testament/deftest test-name
                         (testament/assert-equal 1 1))
      (testament/run-tests! :silent true))
    #
    @[@{:test     'test-name
        :failures @[]
        :passes   @[{:test    'test-name
                     :kind    :equal
                     :passed? true
                     :expect  1
                     :actual  1
                     :note    "(= 1 1)"}]}])
  # => true

  (deep=
    #
    (defer (testament/reset-tests!)
      (testament/deftest test-name
                         (testament/assert-equal 1 2))
      (testament/run-tests! :silent true
                            :exit-on-fail false))
    #
    @[@{:test     'test-name
        :passes   @[]
        :failures @[{:test    'test-name
                     :kind    :equal
                     :passed? false
                     :expect  1
                     :actual  2
                     :note    "(= 1 2)"}]}])
  # => true

  (defer (testament/reset-tests!)
    (testament/deftest test-name
                       (testament/assert-equal 1 1))
    (let [output @""
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
        (testament/run-tests!))
      (= (string "\n"
                 rule "\n"
                 stats "\n"
                 rule "\n")
         (string output))))
  # => true

  (defer (testament/reset-tests!)
    (testament/set-report-printer
      (fn [notests noasserts nopassed]
        (print "CUSTOM:" notests ":" noasserts ":" nopassed ":")))
    (testament/deftest test-name
                       (testament/assert-equal 1 1))
    (let [output @""]
      (with-dyns [:out output]
        (testament/run-tests!))
      (= (string "CUSTOM:1:1:1:" "\n")
         (string output))))
  # => true

  (defer (testament/reset-tests!)
    (var called false)
    (testament/set-on-result-hook
      (fn [summary]
        (unless (= summary {:test    'test-name
                            :kind    :equal
                            :passed? true
                            :expect  1
                            :actual  1
                            :note   "1"})
          (error "Test failed"))
        (set called true)))
    (testament/deftest test-name
                       (testament/assert-equal 1 1 "1"))
    (let [output @""]
      (with-dyns [:out output]
        (testament/run-tests!))
      called))
  # => true

  (defer (testament/reset-tests!)
    (testament/deftest test-name
                       (testament/assert-equal 1 1))
    (let [output @""]
      (with-dyns [:out output]
        (testament/run-tests! :silent true))
      output))
  # => @""

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
