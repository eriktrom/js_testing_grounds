do ->
  Circle = (radius) ->
    @radius = radius

  test "circle test", ->
    circ = new Circle(6)
    circ2 = { radius: 6}

    ok(circ instanceof Object)
    ok(circ instanceof Circle)
    ok(circ2 instanceof Object)
    ok !(circ2 instanceof Circle)

    ok(Circle is circ.constructor)
    ok(Object is circ2.constructor)

    # a instanceof b will return true whenever the internal [[Prototype]]
    # property of a, or one of the objects on its prototype chain, is the same
    # object as b.prototype

  test "create another object of the same kind using Circle.constructor", ->
    circle = new Circle(6)
    circle2 = new circle.constructor(9)

    ok(circle.constructor is circle2.constructor)
    ok(circle2 instanceof Circle)

  # when using new SomeConstructor
    # 1. A new object is created
    # 2. that object is given the prototype from the constructor
    # 3. the constructor is executed (in the new object's context)

do ->
  Gift = (@name) ->
    Gift.count++
    @day = Gift.count
    @announce()

  Gift.count = 0
  Gift::announce = ->
    "On day #{@day} of Christmas I received #{@name}"

  test "it works", ->
    gift1 = new Gift('a partridge and a pear tree')
    gift2 = new Gift('two turtle doves')

    ok(gift1 is "On day 1 of Christmas I received a partridge in a pear tree")
    ok(gift2 is "On day 2 of Christmas I received two turtle doves")


do ->
  # dealing with 3 objects:
  # 1. Tribble object itself, which is actually the constructor function
  # 2. Tribble.prototype
  # 3. Tribble instance

  # by default, Tribble properties (other than constructor) are attached to the
  # prototype
  # using the @something:, we want the to attach the property to the class object
  # itself

  # Functions attached to the prototype are invoked in the context of an
  # individual object(as is the constructor), we need to attach a seperate
  # isAlive property to each instance

  class Tribble
    constructor: ->
      @isAlive = true
      Tribble.count++

    # prototype properties
    # Tribble.prototype.breed = ...
    breed: -> new Tribble if @isAlive
    # Tribble.die = ...
    die: ->
      Tribble.count-- if @isAlive
      @isAlive = false

    # class level properties
    # note that
    @count: 0 # Tribble.count = 0

    # Tribble.makeTrouble = ((function() {...}))
    @makeTrouble: ("Trouble" for i in [1..@count]).join(' ')