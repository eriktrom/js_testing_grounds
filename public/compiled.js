// Generated by CoffeeScript 1.6.1

(function() {
  var Circle;
  Circle = function(radius) {
    return this.radius = radius;
  };
  test("circle test", function() {
    var circ, circ2;
    circ = new Circle(6);
    circ2 = {
      radius: 6
    };
    ok(circ instanceof Object);
    ok(circ instanceof Circle);
    ok(circ2 instanceof Object);
    ok(!(circ2 instanceof Circle));
    ok(Circle === circ.constructor);
    return ok(Object === circ2.constructor);
  });
  return test("create another object of the same kind using Circle.constructor", function() {
    var circle, circle2;
    circle = new Circle(6);
    circle2 = new circle.constructor(9);
    ok(circle.constructor === circle2.constructor);
    return ok(circle2 instanceof Circle);
  });
})();

(function() {
  var Gift;
  Gift = function(name) {
    this.name = name;
    Gift.count++;
    this.day = Gift.count;
    return this.announce();
  };
  Gift.count = 0;
  Gift.prototype.announce = function() {
    return "On day " + this.day + " of Christmas I received " + this.name;
  };
  return test("it works", function() {
    var gift1, gift2;
    gift1 = new Gift('a partridge and a pear tree');
    gift2 = new Gift('two turtle doves');
    ok(gift1 === "On day 1 of Christmas I received a partridge in a pear tree");
    return ok(gift2 === "On day 2 of Christmas I received two turtle doves");
  });
})();

(function() {
  var Tribble;
  return Tribble = (function() {
    var i;

    function Tribble() {
      this.isAlive = true;
      Tribble.count++;
    }

    Tribble.prototype.breed = function() {
      if (this.isAlive) {
        return new Tribble;
      }
    };

    Tribble.prototype.die = function() {
      if (this.isAlive) {
        Tribble.count--;
      }
      return this.isAlive = false;
    };

    Tribble.count = 0;

    Tribble.makeTrouble = ((function() {
      var _i, _ref, _results;
      _results = [];
      for (i = _i = 1, _ref = Tribble.count; 1 <= _ref ? _i <= _ref : _i >= _ref; i = 1 <= _ref ? ++_i : --_i) {
        _results.push("Trouble");
      }
      return _results;
    })()).join(' ');

    return Tribble;

  })();
})();
