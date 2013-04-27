# prototypes were discussed in 6.1.3, 6.2.2, 9.1
# constructors were discussed in 4.6, 6.1.2, 8.2.3, 9.2
# classical classes 9.3
# dynamically extendable classes - 9.4
# testing the class of an object - 9.5
# duck typing - 9.5
# extending & subclass other classes, with examples - 9.7
# new things you can do with class ES5 - 9.8
# modules, re-usable code - 9.9

### Classes and Constructors ###
# Constructors:
# - needs to initialize the state of a new object
# - the prototype property of the constructor is used as the prototype of the
#   new object
# - constructor invocation automatically creates a new object, invokes the
#   constructor as a method of that object, and returns the new object


do ->
  # Constructors and Class Identity
  # - two objects are instances of the same class if and only if they inherit
  #   from the same prototype object
  # - the constructor function that initializes the state of a new object is NOT
  #   fundamental: two constructor functions may have prototype properties that
  #   point to the same object.

  Range = (from, to) ->
    # non inherited properties unique to this object
    @from = from
    @to = to

  Range:: =
    includes: (x) -> @from <= x && x <= @to # return true if x is in the range
    foreach: (f) ->
      x = Math.ceil(@from)
      while x <= @to then f(x); x++
      # for x in Math.ceil(@from) <= @to then f(x); x++
      return
    toString: -> "(#{@from}...#{@to})"

  module "Range",
    setup: -> @r = new Range(1, 3)
  test "#includes", ->
    ok(@r.includes(2))
  test "membership in class", ->
    ok(@r instanceof Range)
    # this does not actually check whether r was initialized by range constructor
    # but instead checks whether it inherits from Range.prototype


do ->
  ### The Constructor Property
  - any javascript FUNCTION can be used as a constructor
  - a constructor invocation needs a prototype property
  - every js FUNCTION (except ES5 bind) automatically has a prototype property
    - the value of this property is an object that has a single non-enumerable
      constructor property
      - the value of the constructor property is the function object
  RE-READ THIS ^^
  ###

  F = -> # a function object
  p = F:: # prototype property of F
  c = p.constructor # object with a single non-enumerable constructor property
  module "Constructor Property"
  test "F.prototype.constructor === F for any function", ->
    ok  c is F

  ###
  - The existance of this predefined prototype object with its constuctor property
    means that objects typically inherit a constructor property that refers to
    their constructor.
  - Thus, the constructor property gives the class of an object
  ###

  test "the constructor property gives the class of an object", ->
    o = new F()
    ok  o.constructor is F
    ok  o.constructor is c

  test "there is a back reference from the prototype to the constructor", ->
    ok  (F::) is p
    # ok

### Notes:
- a class of objects share certain properties
- members or instances of this class have their own properties to hold or define
  their state
- they also have properties (methods) that define their behavior
  - this behavior is defined by the class and is shared by all instances
- methods of an object are typically inherited properties <-- key feature in js
- Objects created using the new keyword and a constructor invocation use the
  value of the prototype property of the constructor function as their prototype
  - Object.create is a 'static function', not a method invoked on individual objects
  - inheritance occurs when querying properties but not when setting them - key to js,
    b/c it allows us to *selectively* override inherited properties
###