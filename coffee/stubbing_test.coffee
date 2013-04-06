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

# src/dependency.coffee
do ->
  dependencyObject = app.namespace("dependencyObject")
  dependencyMethod = ->
  dependencyObject.dependencyMethod = dependencyObject

### src/sut.coffee ###
do ->
  myObject = app.namespace("myObject")
  dependencyObject = app.dependencyObject
  myMethod = -> dependencyObject.dependencyMethod()
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

### End example of stubbing ###
