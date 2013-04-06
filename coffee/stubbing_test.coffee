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
    # this test is currently failing b/c dependencyObject.dependencyMethod()
    # stub does not return an object, so when the app code calls:
    # `dep.aReturnedObject("dependencyMethodArg", myMethodArg)`, its essentially
    # trying to call `undefined.aReturnedObject("dependencyMethodArg", myMethodArg)`
    # which won't work.
    dependencyObject.dependencyMethod = stubber.stubFn()
    myObject.myMethod()
    ok(dependencyObject.dependencyMethod.called)

  test "it returns the object or value given through argument", ->
    actual = null
    # in contrast to the previous test, we use stubFn to create one stub,
    # while manually creating a stub aReturnedObject method in order to inspect
    # its received arguments

    # this stub DOES return an object, therefore when calling:
    # `dep.aReturnedObject("dependencyMethodArg", myMethodArg)`, dep is defined,
    # and it is a function we can call, it does receive arguments, and therefore,
    # we can inspect those arguments
    dependencyObject.dependencyMethod = stubber.stubFn
      aReturnedObject: ->
        actual = arguments

    myObject.myMethod("myMethodArg")

    # Note the use of Array::slice.call(actual)
    #   when we add argument inspection to our stubber, we'll have to remember
    #   to bring this along. I am not sure why this is not in the book
    deepEqual(Array::slice.call(actual), ["dependencyMethodArg", "myMethodArg"])

### End example of stubbing ###
