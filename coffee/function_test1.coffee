###
function delclaration
- named function expressions and function declarations are similar. Sometimes,
  there is no other way to tell them apart, other than the context in which 
  the function occurs <-- occurs? cant say 'is defined or declared, weird'
- callbacks will unviel more of this
- semi-colon is not needed
###
`
function foo() {

}
`

### named function experession
useful for:
  - debugging in browsers
  - calling function recursively from itself(there is a way to do this
    with anonymous functions too, fibonoci sequence is two books at least,
    tddjs book uses js to w/ named function expression, smooth coffeescript does
    it without, i think)
- traling semi-colon is needed here
###
`
var add_w_name = function add_w_name(a, b) {
  return a + b;
}; // I dont thik you need the ; but apparently, you can still use it
`

### 
anonymous function 
unnamed funtion expression
function expression
###
add_wout_name = (a, b) ->
  a + b



module "functions"
# all three of these fail in IE 8

test "foo has a name property 'foo'", ->
  strictEqual(foo.name, 'foo')

test "add_w_name has a name property", ->
  strictEqual(add_w_name.name, 'add_w_name')

test "add_wout_name has name property as empty string", ->
  strictEqual(add_wout_name.name, '')

