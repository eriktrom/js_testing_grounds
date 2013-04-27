### Partial Application Examples ###

Et = {}
Et.array = (a, n) -> Array::slice.call(a, n || 0)

module "Et.array"
test "it should turn an arguments object into an array", ->
  ok(true)