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
  # app.namespace("ajax") needs to be called before app.ajax will work,
  # thus, the first file that uses app.ajax should define this, in face,
  # its just good practice to define it inside any file that will use this
  ajax = app.namespace("ajax")

  get = (url) ->
    unless typeof url is "string" then throw new TypeError("URL should be string")

  ajax.get = get

# test/request_test.coffee
do ->
  # ajax = app.ajax would work here too b/c we defined app.namespace("ajax")
  # in the source file. defining it here though like this would mean we
  # are not implicitly testing that our source file does so, thus, maybe we
  # should not define this here
  # ajax = app.namespace("ajax")
  ajax = app.ajax

  module "app.ajax"

  test "it should define a get method", ->
    ok(typeof ajax.get is "function")

  module "app.ajax.get"

  test "it throws an error without url arg", ->
    throws ->
      ajax.get()
    , TypeError