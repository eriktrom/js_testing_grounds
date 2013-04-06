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

  stubFn = (returnedObject) ->
    fn = ->
      fn.called = true
      returnedObject
    fn.called = false
    fn

  stubber.stubFn = stubFn

# src/dependency.coffee
do ->
  dependencyObject = app.namespace("dependencyObject")
  dependencyMethod = ->
  dependencyObject.dependencyMethod = dependencyObject

### src/sut.coffee ###
do ->
  myObject = app.namespace("myObject")
  dependencyObject = app.dependencyObject
  myMethod = (myMethodArg) ->
    dep = dependencyObject.dependencyMethod()
    dep.aReturnedObject("dependencyMethodArg", myMethodArg)
  myObject.myMethod = myMethod

### test/stub_test.coffee ###
do ->
  dependencyObject = app.dependencyObject
  myObject = app.myObject
  stubber = app.stubber

  module "app.stubber",
    setup: ->
      @originalDependencyMethod = dependencyObject.dependencyMethod
    teardown: ->
      dependencyObject.dependencyMethod = @originalDependencyMethod

  test "it sets a flag when a method is called", ->
    dependencyObject.dependencyMethod = stubber.stubFn()
    myObject.myMethod()
    ok(dependencyObject.dependencyMethod.called)

  test "it returns the object or value given through argument", ->
    actual = null
    dependencyObject.dependencyMethod = stubber.stubFn
      aReturnedObject: ->
        actual = arguments

    myObject.myMethod("myMethodArg")

    deepEqual(Array::slice.call(actual), ["dependencyMethodArg", "myMethodArg"])

### End example of stubbing ###
