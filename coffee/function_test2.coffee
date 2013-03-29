class OutputHolder
  setPublicProperty: (key, value) ->
    @[key] = value

`
function foo() {
  return 'global foo';
}

function bar() {
  return 'global bar';
}

function hoistMe() {

  outputHolder = new OutputHolder();
  outputHolder.setPublicProperty('typeOfFoo', typeof foo);
  outputHolder.setPublicProperty('typeOfBarBeforeDefinition', typeof bar);

  function foo() {
    return 'hoistMe foo';
  }

  var bar = function() {
    return 'wont hoistMe bar';
  };

  outputHolder.setPublicProperty('typeOfBarAfterDefinition', typeof bar);
  outputHolder.setPublicProperty('valueOfBarAfterDefinition', bar());
}
hoistMe();
`

module "OutputHolder"

test "it sets public properties on instances of outputHolder", ->
  outputHolder = new OutputHolder()
  outputHolder.setPublicProperty('hello', 'world')
  strictEqual outputHolder.hello, 'world'

test "new OutputHolder() works identical to new OutputHolder;", ->
  outputHolder1 = new OutputHolder
  outputHolder1.setPublicProperty('hello', 'from outputHolder1')
  strictEqual outputHolder1.hello, 'from outputHolder1'

  outputHolder2 = new OutputHolder() # <--- testing for ()
  outputHolder2.setPublicProperty('hello', 'from outputHolder2')
  strictEqual outputHolder2.hello, 'from outputHolder2'

module "Function Hoisting"

test '''foo definition inside hoistMe gets assigned to global declaration of foo 
      variable before foo is even run''', ->
  strictEqual outputHolder.typeOfFoo, "function"

test '''bar definition inside hoistMe does not get assigned to global,
      but it does override the global definition with undefined''', ->
  strictEqual(outputHolder.typeOfBarBeforeDefinition, "undefined")

test "bar variable inside hoistMe after its defined", ->
  strictEqual(outputHolder.typeOfBarAfterDefinition, "function")
  strictEqual(outputHolder.valueOfBarAfterDefinition, 'wont hoistMe bar')

test "that outputHolder is does not have hello property as defined in first test", ->
  ok(outputHolder.hello is undefined)

