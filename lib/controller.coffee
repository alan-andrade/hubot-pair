Pair = require '../lib/pair'
_ = require 'underscore'

class Controller
  constructor: ->
    @free_devs = new Pairs
    @busy_devs = new Pairs

  add: (name, time=60) ->
    @free_devs.add(new Pair(name, time))

  pair: (id1, id2) ->
    dev1 = @free_devs.get(id1)
    dev2 = @free_devs.get(id2)
    if dev1 && dev2
      dev1.pairWith(dev2)
      @free_devs.delete(dev1)
      @free_devs.delete(dev2)
      @busy_devs.add(dev1)
      @busy_devs.add(dev2)

  get_free_devs: -> @free_devs
  get_busy_devs: -> @busy_devs

class Pairs
  constructor: ->
    @pairs = _([])

  add: (pair) ->
    @pairs.push pair

  get: (id) ->
    @pairs.find (pair) -> pair.name == id

  delete: (pair) ->
    @pairs = _(@pairs.without pair)

  size: ->
    @pairs.size()

  free: ->
    @pairs.filter (pair) -> !pair.isPairing

  toMsg: ->
    @pairs.join(', ')

module.exports = Controller
