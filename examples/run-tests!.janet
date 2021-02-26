(import ../src/testament)

(comment

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

  )
