XDate = require 'xdate'

class Pair
  constructor: (@name, @availability=60) ->
    @started = new XDate
    @isPairing = false
    @pairingWith = null

  timeLeft: ->
    Math.round(@availability - @started.diffMinutes(new Date))

  pairWith: (pair) ->
    @isPairing = true
    pair.isPairing = true
    @pairingWith = pair
    pair.pairingWith = this

  toString: ->
    "#{@name}[#{@timeLeft()}]"

module.exports = Pair
