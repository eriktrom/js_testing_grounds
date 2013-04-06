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
    unless typeof url is "string" then throw new TypeError("URL should be string")

  ajax.get = get

# test/request_test.coffee
do ->
  ajax = app.ajax

  module "app.ajax"

  test "it should define a get method", ->
    ok(typeof ajax.get is "function")

  module "app.ajax.get"

  test "it throws an error without url arg", ->
    throws ->
      ajax.get()
    , TypeError