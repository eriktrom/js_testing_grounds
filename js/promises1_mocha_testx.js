// Generated by CoffeeScript 1.6.2
chai.should();

describe("delay", function() {
  return it("delays", function(done) {
    var delay, doSomething, success, testDbl;

    testDbl = {};
    success = function() {
      var deferred;

      deferred = Q.defer();
      testDbl.something = "something";
      return deferred.promise;
    };
    doSomething = function() {
      return Q.promise(success);
    };
    delay = function(ms) {
      var deferred;

      deferred = Q.defer();
      setTimeout(deferred.resolve, ms);
      return deferred.promise;
    };
    delay(1000).then(doSomething);
    doSomething().should.eventually.equal("b");
    return done();
  });
});

describe("testing promises", function() {
  var aDeferred, bDeferred, moduleA, moduleB;

  aDeferred = Q.defer();
  bDeferred = Q.defer();
  moduleA = {
    asyncMethodA: function() {
      return aDeferred.promise;
    }
  };
  moduleB = {
    asyncMethodB: function() {
      return bDeferred.promise;
    }
  };
  return it("should pass", function(done) {
    sinon.spy(moduleA, 'asyncMethodA');
    sinon.spy(moduleB, 'asyncMethodB');
    aDeferred.resolve('fooResolve');
    bDeferred.resolve('barResolve');
    moduleA.asyncMethodA('foo').then(function(value) {
      var promise;

      console.log(value);
      promise = moduleB.asyncMethodB('bar');
      moduleB.asyncMethodB.should.have.been.called;
      return promise;
    }).then(function(value) {
      return console.log(value);
    }).fail(function(err) {
      return console.log(err);
    }).should.notify(done);
    moduleA.asyncMethodA.should.have.been.called;
    return moduleB.asyncMethodB.should.have.been.called;
  });
});

/*
//@ sourceMappingURL=promises1_mocha_testx.map
*/
