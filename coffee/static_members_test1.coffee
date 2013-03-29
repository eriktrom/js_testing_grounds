# constructor
Gadget = ->

# public static method (public class method)
Gadget.isShiny = ->
  "you bet"

# Normal method added to the prototype
Gadget::setPrice = (price) ->
  @price = price

module "Gadget",
  setup: ->
    @iphone = new Gadget()


# ALERT - HAVING THIS TEST HERE WILL CAUSE OTHERS TO FAIL - HOW DO I TEST THIS
# WITHOUT RUINING IT FOR ALL THE OTHER TESTS? RE-ASSIGNMENT? WRAP THE DEFINITION
# IN A CLOSURE? APPLY? CALL? WTF... 
# test "setting up a facade to allow instance access to its static methods", ->
#   GadgetDbl = do -> 
#     F = ->
#     GadgetDbl:: = Gadget
#   iphoneLocal = new GadgetDbl()
#   GadgetDbl::isShiny = GadgetDbl.isShiny
#   ok(iphoneLocal.isShiny() is "you bet")

test "the constructor Gadget has a public static method (public class method)", ->
  ok(Gadget.isShiny() is "you bet")

test "an instance of Gadget does NOT have access its constructor's public static methods", ->
  throws ->
    @iphone.isShiny()
  , TypeError

test "calling a static method from an instance WON'T work", ->
  ok(@iphone.isShiny is undefined)
    

test "creating an instance and calling a method does work", ->
  ok(@iphone.setPrice(500))

test "attempting to call an instance method statically won't work", ->
  ok(Gadget.setPrice is undefined)

# THIS IS THE SAME TEST FROM THE TOP
# TEST ORDER SHOULD NOT MATTER, AND HERE, IT CLEARLY DOES.
test "setting up a facade to allow instance access to its static methods", ->
  GadgetDbl = do -> Gadget
  # GadgetDbl = Gadget.constructor
  iphoneLocal = new GadgetDbl()
  GadgetDbl::isShiny = GadgetDbl.isShiny
  ok(iphoneLocal.isShiny() is "you bet")