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
    fn #<-- return a function object, which, when called, will return
       # returnedDependencyObject

  stubber.stubFn = stubFn

# src/collaberator_factory.coffee
do ->
  collaberatorFactory = app.namespace("collaberatorFactory")
  createDependencyObject = ->
  collaberatorFactory.createDependencyObject = createDependencyObject

  module "collaberatorFactory"
  test "is an object", ->
    ok(typeof collaberatorFactory is "object")
    ok(typeof collaberatorFactory isnt "function")

  module "collaberatorFactory#createDependencyObject"
  test "is a function", ->
    ok(typeof collaberatorFactory.createDependencyObject is "function")
    ok(typeof collaberatorFactory.createDependencyObject isnt "object")

### src/sut.coffee ###
do ->
  myObject = app.namespace("myObject")
  collaberatorFactory = app.collaberatorFactory
  myMethod = (myMethodArg) ->
    returnedDependencyObject = collaberatorFactory.createDependencyObject()
    returnedDependencyObject
      .understoodMessage("createDependencyObjectArg", myMethodArg)
  myObject.myMethod = myMethod

  module "myObject"
  test "is an object", -> ok(typeof myObject is "object")
  module "myObject#myMethod"
  test "is a function", -> ok(typeof myObject.myMethod is "function")

### test/stub_test.coffee ###
do ->
  collaberatorFactory = app.collaberatorFactory
  myObject = app.myObject
  stubber = app.stubber

  module "app.stubber",
    setup: ->
      @originalCreateDependencyObject =
        collaberatorFactory.createDependencyObject
    teardown: ->
      collaberatorFactory.createDependencyObject =
          @originalCreateDependencyObject

  test "sets a flag when a method is called", ->
    collaberatorFactory.createDependencyObject =
      stubber.stubFn(understoodMessage: ->)

    myObject.myMethod()

    ok(collaberatorFactory.createDependencyObject.called)

  test "returns the object or value given through argument", ->
    returnedDependencyObjectDbl = stubber.stubFn()
    collaberatorFactory.createDependencyObject =
      stubber.stubFn(understoodMessage: returnedDependencyObjectDbl)

    myObject.myMethod("myMethodArg")

    deepEqual returnedDependencyObjectDbl.args,
              ["createDependencyObjectArg", "myMethodArg"]

### End example of stubbing ###
