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

ajax = app.namespace("ajax")
ajax.get = ->

module "app"

test "it should define a get method", ->
  ok(typeof ajax.get is "function")