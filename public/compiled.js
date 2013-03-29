// Generated by CoffeeScript 1.6.1
/*
code re-use, inheritance, modules, mixins, constructors, the js object model
- pick modern patterns for code re-use instead of classical ones in js
- we'll start with classical though, then move on to modern
*/

/*
Classical Inheritance
goal - have objects created by one constuctor function
get properties that come from another constructor Parent()
*/

(function() {
  var Child, Parent, hasOwnProperty, hasOwnPropertyWithValue, hasProperty, hasPropertyWithValue, inherit, kid;
  hasProperty = function(object, key) {
    return key in object;
  };
  hasOwnProperty = function(object, key) {
    return {}.hasOwnProperty.call(object, key);
  };
  hasPropertyWithValue = function(object, key, value) {
    return object[key] === value;
  };
  hasOwnPropertyWithValue = function(object, key, value) {
    return hasOwnProperty(object, key) && hasPropertyWithValue(object, key, value);
  };
  return module("Example 1", inherit = function(C, P) {
    return C.prototype = new P();
  }, Parent = function(name) {
    return this.name = name || 'Erik';
  }, Parent.prototype.say = function() {
    return this.name;
  }, Child = function(name) {}, inherit(Child, Parent), kid = new Child(), test("an instance of the child inherits instance methods of parent", function() {
    return ok(kid.say() === 'Erik');
  }), test("setting kid.name adds name property to object #3", function() {
    var parent;
    kid.name = "BabyE";
    ok(kid.say() === "BabyE");
    ok(hasOwnPropertyWithValue(kid, "name", "BabyE"));
    ok(hasProperty(kid, "name"));
    parent = new Parent();
    ok(hasOwnPropertyWithValue(parent, "name", "Erik"));
    ok(hasOwnProperty(Parent, "name"));
    ok(hasProperty(Parent, "name"));
    ok(hasPropertyWithValue(Parent.prototype, "name", void 0));
    ok(hasOwnPropertyWithValue(Parent.prototype, "name", void 0) === false);
    ok(typeof Parent.prototype.constructor.prototype.constructor.prototype === "object");
    ok(typeof Parent.prototype.constructor.prototype.constructor.prototype !== "function");
    ok(typeof Parent.prototype.constructor.prototype.constructor === "function");
    ok(typeof Parent.prototype.constructor.prototype.constructor !== "object");
    ok(typeof Parent.prototype.constructor.prototype === "object");
    ok(typeof Parent.prototype.constructor.prototype !== "function");
    ok(typeof Parent.prototype.constructor === "function");
    ok(typeof Parent.prototype.constructor !== "object");
    ok(typeof Parent.prototype === "object");
    ok(typeof Parent.prototype !== "function");
    ok(typeof Parent === "function");
    ok(typeof Parent !== "object");
    ok(typeof parent === "object");
    ok(typeof parent !== "function");
    ok(typeof kid === "object");
    return ok(typeof kid !== "function");
  }));
})();