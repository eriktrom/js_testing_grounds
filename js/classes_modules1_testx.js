// Generated by CoffeeScript 1.6.2
/* Classes and Constructors
*/
(function() {
  var Range;

  Range = function(from, to) {
    this.from = from;
    return this.to = to;
  };
  Range.prototype = {
    includes: function(x) {
      return this.from <= x && x <= this.to;
    },
    foreach: function(f) {
      var x;

      x = Math.ceil(this.from);
      while (x <= this.to) {
        f(x);
        x++;
      }
    },
    toString: function() {
      return "(" + this.from + "..." + this.to + ")";
    }
  };
  module("Range", {
    setup: function() {
      return this.r = new Range(1, 3);
    }
  });
  test("#includes", function() {
    return ok(this.r.includes(2));
  });
  return test("membership in class", function() {
    return ok(this.r instanceof Range);
  });
})();

(function() {
  /* The Constructor Property
  - any javascript FUNCTION can be used as a constructor
  - a constructor invocation needs a prototype property
  - every js FUNCTION (except ES5 bind) automatically has a prototype property
    - the value of this property is an object that has a single non-enumerable
      constructor property
      - the value of the constructor property is the function object
  RE-READ THIS ^^
  */

  var F, c, p;

  F = function() {};
  p = F.prototype;
  c = p.constructor;
  module("Constructor Property");
  test("F.prototype.constructor === F for any function", function() {
    return ok(c === F);
  });
  /*
  - The existance of this predefined prototype object with its constuctor property
    means that objects typically inherit a constructor property that refers to
    their constructor.
  - Thus, the constructor property gives the class of an object
  */

  test("the constructor property gives the class of an object", function() {
    var o;

    o = new F();
    ok(o.constructor === F);
    return ok(o.constructor === c);
  });
  return test("there is a back reference from the prototype to the constructor", function() {
    return ok(F.prototype === p);
  });
})();

/* Notes:
- a class of objects share certain properties
- members or instances of this class have their own properties to hold or define
  their state
- they also have properties (methods) that define their behavior
  - this behavior is defined by the class and is shared by all instances
- methods of an object are typically inherited properties <-- key feature in js
- Objects created using the new keyword and a constructor invocation use the
  value of the prototype property of the constructor function as their prototype
  - Object.create is a 'static function', not a method invoked on individual objects
  - inheritance occurs when querying properties but not when setting them - key to js,
    b/c it allows us to *selectively* override inherited properties
*/


/*
//@ sourceMappingURL=classes_modules1_testx.map
*/