app = do ->
  namespace = (string) ->
    object = @
    levels = string.split(".")

    for level in levels
      if typeof object[level] is "undefined"
        object[level] = {}
      object = object[level]
    object

  {namespace}

# lib/stub.coffee
do ->
  stubber = app.namespace("stubber")

  stubFn = ->
    fn = ->
      fn.called = true
    fn.called = false
    fn

  stubber.stubFn = stubFn

###
Stubbing Example - where myObject has a method, myMethod, that calls
dependencyObject.dependencyMethod()
- Given I stub dependencyObject.dependencyMethod = stubFn()
- When I call myObject.myMethod
- Then dependencyObject.dependencyMethod should have been called
###

# src/dependency.coffee

# first, wrap any module in a anonymous function closure
do ->
  # then, declare a namespace for the module, and assign it to local var
  #   note, this creates a new object
  dependencyObject = app.namespace("dependencyObject")

  # then, define methods(functions) - (not currently assigned to any object)
  dependencyMethod = ->

  # then export methods by assigning them as properties on the object created
  # by app.namespace
  dependencyObject.dependencyMethod = dependencyObject

### src/sut.coffee ###
do ->
  myObject = app.namespace("myObject")

  # import previously defined objects
  #   note, the dependency needs to have been created already, meaning, in this
  #   case, load order does matter
  dependencyObject = app.dependencyObject

  # objects have expectations about the messages their collaberators understand
  myMethod = -> dependencyObject.dependencyMethod()

  myObject.myMethod = myMethod

### test/stub_test.coffee ###
do ->
  # import all needed object for this test, starting with application
  #   note: order them like they are ordered in app, import test helper last
  dependencyObject = app.dependencyObject
  myObject = app.myObject
  stubber = app.stubber

  module "app.stubber",
    setup: ->
      @originalDependencyMethod = dependencyObject.dependencyMethod
    teardown: ->
      dependencyObject.dependencyMethod = @originalDependencyMethod

  test "it sets a flag when a method is called", ->
    # stub method on collaberator, b/c:
    # objects have expectations about the messages their collaberators understand
    dependencyObject.dependencyMethod = stubber.stubFn()
    myObject.myMethod()
    ok(dependencyObject.dependencyMethod.called)

### End example of stubbing ###
