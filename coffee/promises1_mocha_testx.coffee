# expect = chai.expect
chai.should()

describe "delay", ->
  it "delays", (done) ->
    testDbl = {}
    success = ->
      deferred = Q.defer()
      testDbl.something = "something"
      deferred.promise

    doSomething = -> Q.promise(success)

    delay = (ms) ->
      deferred = Q.defer()
      setTimeout(deferred.resolve, ms)
      deferred.promise
    delay(1000).then(doSomething)

    doSomething().should.eventually.equal "b"
    done()

describe "testing promises", ->
  aDeferred = Q.defer()
  bDeferred = Q.defer()

  moduleA =
    asyncMethodA: -> aDeferred.promise

  moduleB =
    asyncMethodB: -> bDeferred.promise

  it "should pass", (done) ->
    sinon.spy(moduleA, 'asyncMethodA')
    sinon.spy(moduleB, 'asyncMethodB')

    aDeferred.resolve('fooResolve')
    bDeferred.resolve('barResolve')

    moduleA.asyncMethodA('foo').then (value) ->
      console.log(value)
      promise = moduleB.asyncMethodB('bar')
      moduleB.asyncMethodB.should.have.been.called
      promise
    .then (value) ->
      console.log(value)
    .fail (err) ->
      console.log(err)
    .should.notify(done)

    moduleA.asyncMethodA.should.have.been.called
    moduleB.asyncMethodB.should.have.been.called