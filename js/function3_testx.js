// Generated by CoffeeScript 1.6.2
/* Partial Application Examples
*/

var Et;

Et = {};

Et.array = function(a, n) {
  return Array.prototype.slice.call(a, n || 0);
};

module("Et.array");

test("it should turn an arguments object into an array", function() {
  return ok(true);
});

/*
//@ sourceMappingURL=function3_testx.map
*/