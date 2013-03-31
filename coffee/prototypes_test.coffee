# Every object has a prototype
# Since prototypes are objects themselves, every prototype has a prototype(one 
  # exception is the default object prototype at the top of every prototype chain)

# an object is any unordered collection of key-value pairs 
  # if its not undefined, null, boolean, number or string, its a prototype

do ->
  module "Prototypes"

  test "{}.prototype is undefined", ->
    ok(({}).prototype is undefined)