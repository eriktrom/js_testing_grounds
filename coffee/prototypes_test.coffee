# Every object has a prototype
# Since prototypes are objects themselves, every prototype has a prototype(one 
  # exception is the default object prototype at the top of every prototype chain)

# an object is any unordered collection of key-value pairs 
  # if its not undefined, null, boolean, number or string, its a prototype

# do ->
  # module "Prototypes"

  # test "{}.prototype is undefined", ->
    # testDbl = {}
    # # ok(testDbl:: is undefined)
    # ok (testDbl::) is undefined
    # # this shows something important:
    #   # forget everything you thought you knew about prototypes
    #     # the true prototype of an object is held by the internal [[Prototype]]
    #     # property
    # ok testDbl.__proto__ isnt undefined # fails on IE`
    # ok Object.getPrototypeOf(testDbl) isnt undefined # ES5 way, fails on IE

    # # works on every browser as long as:
    #   # 1. constructor.prototype has not been replaced
    #   # 2. object has been created with Object.create
    # ok (testDbl.constructor::) isnt undefined
    # ok (testDbl.constructor::) is "[object Object]"
    # testDbl2 = Object.create({})
    # ok (testDbl2.constructor::) isnt undefined
    # ok (testDbl2.constructor::) is "[object Object]" 