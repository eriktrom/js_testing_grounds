###
code re-use, inheritance, modules, mixins, constructors, the js object model
- pick modern patterns for code re-use instead of classical ones in js
- we'll start with classical though, then move on to modern
###

###
Classical Inheritance
goal - have objects created by one constuctor function
get properties that come from another constructor Parent()
###

# Example 1: define two constructors, Parent() and Child()

do ->


  hasProperty = (object, key) ->
    key of object

  hasOwnProperty = (object, key) ->
    {}.hasOwnProperty.call(object, key)

  hasPropertyWithValue = (object, key, value) ->
    object[key] is value

  hasOwnPropertyWithValue = (object, key, value) ->
    hasOwnProperty(object, key) && hasPropertyWithValue(object, key, value)

  module "Example 1",
    # implementation
    # create an object using the Parent() onstructor 
    # and assign that object to the Child()'s prototype
    # remember, prototype should point to an object, not a function, so it has
    # to point to an instance of an object created with the parent constructor, 
    # not the constructor itself. In other words, make sure you use new P()
    inherit = (C, P) ->
      C:: = new P()

    # the parent constructor
    Parent = (name) ->
      @name = name || 'Erik'
      # @name here is an instance specific property added to @this
      # so when calling new Parent() a new block in memory is created, with
      # data, specifically @name

    # adding functionality to the prototype
    # when you try to access 
    Parent::say = ->
      @name

    # empty child constructor
    Child = (name) ->

    # inheritance magic happens here
    inherit(Child, Parent)

    kid = new Child()

    test "an instance of the child inherits instance methods of parent", ->
      ok(kid.say() is 'Erik')

    # following this pattern you inherit:
    # - own properties(instance specific properties added to this, such as name)
    # - prototype properties and methods (such as say())


    # Explanation of prototype chain, for reference:
    # Think of objects as blocks somewhere in memory
    # - when you create an object such as new Parent(), you create one such block
    #   - lets call it: block #2
    #   - it holds data for the name property
    # - when you attempt to access (new Parent().say()), block #2 doesn't containt
    #   that method. But, using the hidden link __proto__ that points to the
    #   prototype property of the constructor function Parent(), you gain access
    #   to object #1 (Parent.prototype), which can answer the say method
    # - this is important b/c its necessary to know where the data your accessing
    #   or modifying is located. 

    # after using the inherit function, you add a new block, #3, at the bottom
    # of the chain, and its an instance of child
    # whats interesting about this way of doing it is that the prototype link
    # up the chain from block #3 is pointed at block #2 -- this is the design of
    # this particular inheritance structure, just one of many way you could do it

    # here is where the prototype chain is kinda like ruby"
    # - when you do:
    # kid = Child()
    # kid.say()
    # - #3 doesn't have the say() method, so it looks up the chain to #2, which
    # also doesn't have it, so it looks the chain to #1, where say() is defined.
    # Now, inside of say(), there's a reference to this.name, which needs to be
    # resolved. The lookup starts again. 
    # Here's where it gets a bit tricky - if say() has a reference to this.name,
    # 1. What is this pointing to
    # 2. ^^ will define the lookup path for this.name
    # in the example here, this points to #3(kid). #3 doesn't have a name, so 
    # it looks up the chain to #2, which does, and that's where it gets it from
    
    test "setting kid.name adds name property to object #3", ->
      # object #3 is kid, fyi
      # so this time, say() is found on #1, where this.name is referenced, 
      # then lookup for this.name begins again at #3(the reciever of say())
      # where it finds the set property name. Now #2 and #3 both contain the
      # name property, but lookup always begins on the receiver of the message,
      # and then follows the pointers up the prototype chain, returning the first
      # reference it finds. Let's see if we can write some expectations for this
      kid.name = "BabyE"
      ok(kid.say() is "BabyE")
      ok(hasOwnPropertyWithValue(kid, "name", "BabyE"))
      ok hasProperty(kid, "name")

      parent = new Parent()
      ok(hasOwnPropertyWithValue(parent, "name", "Erik"))

      # these are less important and don't prove much
      ok(hasOwnProperty(Parent, "name"))
      ok(hasProperty(Parent, "name"))
      ok(hasPropertyWithValue(Parent::, "name", undefined))
      ok(hasOwnPropertyWithValue(Parent::, "name", undefined) is false)
      
      ok(typeof (Parent::constructor::constructor::) is "object")
      ok(typeof (Parent::constructor::constructor::) isnt "function")

      ok(typeof (Parent::constructor::constructor) is "function")
      ok(typeof (Parent::constructor::constructor) isnt "object")

      ok(typeof (Parent::constructor::) is "object")
      ok(typeof (Parent::constructor::) isnt "function")

      ok(typeof (Parent::constructor) is "function")
      ok(typeof (Parent::constructor) isnt "object")

      ok(typeof (Parent::) is "object")
      ok(typeof (Parent::) isnt "function")

      ok(typeof Parent is "function")
      ok(typeof Parent isnt "object")

      ok(typeof parent is "object")
      ok(typeof parent isnt "function")

      ok(typeof kid is "object")
      ok(typeof kid isnt "function")

