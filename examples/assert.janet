(import ../src/testament)

(comment

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

  )
