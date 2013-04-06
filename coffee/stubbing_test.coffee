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

# src/request.coffee
do ->
  ajax = app.namespace("ajax")

  get = (url) ->
    unless typeof url is "string"
      throw new TypeError("URL should be string")
    transport = app.ajax.create()

  ajax.get = get

# test/request_test.coffee
do ->
  # ajax = app.namespace("ajax")
  ajax = app.ajax
  stubber = app.stubber

  module "app.ajax"

  test "it should define a get method", ->
    ok(typeof ajax.get is "function")

  module "app.ajax.get",
    setup: -> @originalCreate = ajax.create
    teardown: -> ajax.create = @originalCreate

  test "it throws an error without url arg", ->
    throws ->
      ajax.get()
    , TypeError

  test "it should obtain an XMLHttpRequest object", ->
    ajax.create = stubber.stubFn()

    ajax.get("/url")

    ok(ajax.create.called)

