chai = require 'chai'
expect = chai.expect
sinon = require 'sinon'

Pair = require '../lib/pair'
Controller = require '../lib/controller'

describe 'Controller', ->
  beforeEach ->
    @controller = new Controller

  it 'adds jake to the free pairing list', ->
    expect(@controller.get_free_devs().size()).to.eq(0)
    @controller.add 'jake'
    expect(@controller.get_free_devs().size()).to.eq(1)

  it 'formats the list of free pairs', ->
    @controller.add 'jake'
    @controller.add 'fin', 40
    msg = @controller.get_free_devs().toMsg()
    expect(msg).to.eq('jake[60], fin[40]')

  it 'pairs jake and fin', ->
    @controller.add 'jake'
    @controller.add 'fin'
    @controller.pair 'jake', 'fin'
    expect(@controller.get_free_devs().size()).to.eq(0)
    expect(@controller.get_busy_devs().size()).to.eq(2)

 describe 'Pair', ->
   it 'has a name and availability', ->
     pair = new Pair 'jake', 12
     expect(pair.name).to.eq('jake')
     expect(pair.availability).to.eq(12)

   it 'default availability to 60', ->
     pair = new Pair 'jake'
     expect(pair.availability).to.eq(60)

   it 'defaults to not be pairing', ->
     pair = new Pair 'jake'
     expect(pair.isPairing).to.be.false

   it 'reads nicely name[time]', ->
     pair = new Pair 'jake'
     txt = pair.toString()
     expect(txt).to.eq('jake[60]')

   it 'knows when you signed up', ->
     clock = sinon.useFakeTimers(+new Date())
     pair = new Pair 'jake', 30
     clock.tick '00:15:00'
     expect(pair.timeLeft()).to.eq(15)
     clock.restore()

    it 'pairs jake with fin', ->
      jake = new Pair 'jake'
      fin = new Pair 'fin'
      jake.pairWith fin
      for pair in [jake, fin]
        expect(pair.isPairing).to.be.true
      expect(jake.pairingWith).to.eql(fin)
      expect(fin.pairingWith).to.eql(jake)
