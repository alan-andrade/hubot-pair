_ = require 'underscore'
XDate = require 'xdate'

class Developer
  constructor: (@name, @availability=60) ->
    @started = new XDate
    @isPairing = false

  timeLeft: ->
    Math.round(@availability - @started.diffMinutes(new Date))

  toString: ->
    str = "#{@name}"
    str += if @isPairing then '' else "[#{@timeLeft()}]"
    str

class Pair
  constructor: (dev1, dev2)->
    dev1.isPairing = true
    dev2.isPairing = true
    @dev1 = dev1
    @dev2 = dev2

  toString: ->
    "#{@dev1}-#{@dev2}"

class Controller
  constructor: ->
    @devs = new Developers
    @pairs = new Pairs

  add: (name, time=60) ->
    @devs.add(new Developer(name, time))

  display: ->
    if @isEmpty()
      "Nobody is available right now. Good time to sign up"
    else
      "free: #{@devs.display()}\npairing: #{@pairs.display()}"

  isEmpty: ->
    @devs.size() + @pairs.size() == 0

  pair: (id1, id2) ->
    dev1 = @devs.findByName id1
    dev2 = @devs.findByName id2
    dev1 && dev2 && @pairs.add(new Pair(dev1, dev2))

class Collection
  constructor: ->
    @src = _([])

  add: (el) -> @src.push el
  size: -> @src.size()
  display: -> @src.join(', ')
  isEmpty: -> @size == 0

class Pairs extends Collection
class Developers extends Collection
  free: ->
    _(@src.filter (pair) -> !pair.isPairing)

  findByName: (name) ->
    @src.find (dev) -> dev.name == name

  display: ->
    @free().join(', ')

module.exports =
  Controller: Controller
  Developer: Developer
  Pair: Pair
