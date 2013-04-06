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

  stubFn = (returnedDependencyObject) ->
    fn = ->
      fn.called = true
      fn.args = Array::slice.call(arguments)
      returnedDependencyObject
    fn.called = false
    fn

  stubber.stubFn = stubFn

# src/collaberator_factory.coffee
do ->
  collaberatorFactory = app.namespace("collaberatorFactory")
  createDependencyObject = ->
  collaberatorFactory.createDependencyObject = createDependencyObject

### src/sut.coffee ###
do ->
  myObject = app.namespace("myObject")
  collaberatorFactory = app.collaberatorFactory
  myMethod = (myMethodArg) ->
    returnedDependencyObject = collaberatorFactory.createDependencyObject()
    returnedDependencyObject.understoodMessage("createDependencyObjectArg", myMethodArg)
  myObject.myMethod = myMethod

### test/stub_test.coffee ###
do ->
  collaberatorFactory = app.collaberatorFactory
  myObject = app.myObject
  stubber = app.stubber

  module "app.stubber",
    setup: ->
      @originalDependencyMethod = collaberatorFactory.createDependencyObject
    teardown: ->
      collaberatorFactory.createDependencyObject = @originalDependencyMethod

  test "sets a flag when a method is called", ->
    collaberatorFactory.createDependencyObject = stubber.stubFn(understoodMessage: ->)
    myObject.myMethod()
    ok(collaberatorFactory.createDependencyObject.called)

  test "returns the object or value given through argument", ->
    returnedDependencyObjectDbl = stubber.stubFn()
    collaberatorFactory.createDependencyObject =
      stubber.stubFn(understoodMessage: returnedDependencyObjectDbl)

    myObject.myMethod("myMethodArg")
    deepEqual(returnedDependencyObjectDbl.args, ["createDependencyObjectArg", "myMethodArg"])

### End example of stubbing ###
