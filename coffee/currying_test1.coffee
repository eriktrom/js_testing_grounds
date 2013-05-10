# # curried add, accepts partial list of arguments
add = (x, y) ->
  oldx = x
  oldy = y
  if typeof oldy is "undefined"
    return (newy) -> oldx + newy
  x + y
module "currying with add()"

test "it returns a function when called with one one argument", ->
  ok(typeof add(5) is "function")

test "it returns a number value when called twice", ->
  ok(add(3)(4) is 7)

test "create and store a new function", ->
  add2000 = add(2000)
  ok(add2000(10) is 2010)