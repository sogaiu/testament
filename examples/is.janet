(import ../src/testament)

(comment

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

  )
