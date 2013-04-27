expect = chai.expect
chai.should()






describe "Array", ->
  it "should return -1 when the value is not present", ->
    expect([1, 2, 3].indexOf(5)).to.equal(-1)


describe "Something Async", ->
  it "should eventually do something", (done) ->
    doSomethingAsync().should.eventually.equal("foo").notify(done)

  it "should eventually do something, but be tested in an ugly manner", (done) ->
    doSomethingAsync().then(
      (result) ->
        result.should.equal("foo")
        done()
      ,
      (err) ->
        done(err)
    )