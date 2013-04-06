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
    ajax.create = ->
      ajax.create.called = true

    ajax.get("/url")

    ok(ajax.create.called)