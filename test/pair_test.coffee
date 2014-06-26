chai = require 'chai'
expect = chai.expect
sinon = require 'sinon'

pairme = require '../lib/pairme'
Developer = pairme.Developer
Pair = pairme.Pair
Controller = pairme.Controller

describe 'Controller', ->
  beforeEach ->
    @controller = new Controller

  it 'adds jake to the developers list', ->
    expect(@controller.devs.size()).to.eq(0)
    @controller.add 'jake'
    expect(@controller.devs.size()).to.eq(1)

  describe 'format', ->
    describe 'empty list', ->
      it 'prints special msg if nobody is available', ->
        expect(@controller.display()).to.match(/Nobody is available/)

      it 'prints available developers', ->
        @controller.add 'jake'
        @controller.add 'fin', 40
        str = @controller.display()
        expect(str).to.match(/jake/)
        expect(str).to.match(/60/)
        expect(str).to.match(/fin/)
        expect(str).to.match(/40/)

      it 'prints pairing developers', ->
        @controller.add 'jake'
        @controller.add 'fin', 40
        @controller.pair 'jake', 'fin'
        expect(@controller.display()).to.match(/jake-fin/)

      it 'prints both states', ->
        @controller.add 'jake'
        @controller.add 'fin', 40
        @controller.pair 'jake', 'fin'
        @controller.add 'iceking'
        expect(@controller.display()).to.match(/iceking/)
        expect(@controller.display()).to.match(/jake-fin/)

  it 'pairs jake and fin', ->
    @controller.add 'jake'
    @controller.add 'fin'
    @controller.pair 'jake', 'fin'
    expect(@controller.devs.size()).to.eq(2)
    expect(@controller.pairs.size()).to.eq(1)

  it 'releases both developers after time is up', ->
    try
      clock = sinon.useFakeTimers(+new Date())
      @controller.add 'jake', 20
      @controller.add 'fin', 15
      @controller.pair 'jake', 'fin'
      clock.tick('00:15:01')
      expect(@controller.pairs.size()).to.eq(0)
    finally
      clock.restore()

 describe 'Developer', ->
   it 'has a name and availability', ->
     dev = new Developer 'jake', 12
     expect(dev.name).to.eq('jake')
     expect(dev.availability).to.eq(12)

   it 'default availability to 60', ->
     pair = new Developer 'jake'
     expect(pair.availability).to.eq(60)

   it 'defaults to not be pairing', ->
     pair = new Developer 'jake'
     expect(pair.isPairing).to.be.false

   it 'reads nicely name[time]', ->
     pair = new Developer 'jake'
     txt = pair.toString()
     expect(txt).to.eq('jake[60]')

   it 'knows when jake started to be available', ->
     clock = sinon.useFakeTimers(+new Date())
     pair = new Developer 'jake', 30
     clock.tick '00:15:00'
     expect(pair.timeLeft()).to.eq(15)
     clock.restore()

  describe 'Pair', ->
    it 'has two developers', ->
      jake = new Developer 'jake'
      fin = new Developer 'fin'
      pair = new Pair jake, fin
      for dev in [jake, fin]
        expect(dev.isPairing).to.be.true

    it 'reads nicely developer1-developer2', ->
      pair = new Pair new Developer('jake'), new Developer('fin')
      expect(pair.toString()).to.eq('jake-fin')

    it 'calculates time left depending on developers timeLeft', ->
      jake = new Developer 'jake', 8
      fin = new Developer 'fin', 15
      pair = new Pair jake, fin
      expect(pair.timeLeft()).to.eq(8)
