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

app.namespace("ajax")

do ->
  ajax = app.ajax

  ajax.get = (url) ->
    unless typeof url is "string" then throw new TypeError("URL should be string")

  module "app.ajax"

  test "it should define a get method", ->
    ok(typeof ajax.get is "function")

  module "app.ajax.get"

  test "it throws an error without url arg", ->
    throws ->
      ajax.get()
    , TypeError