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
app.ajax.get = ->

module "app.ajax"

test "it should define a get method", ->
  ok(typeof app.ajax.get is "function")