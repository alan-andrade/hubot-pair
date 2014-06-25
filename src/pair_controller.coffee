class PairController
  constructor: ->
    @list = []

  add: (name, time=60) ->
    @list.push(new Pair(name, time))

  get_free_pairs: ->
    @list

class Pair
  constructor: (@name, @availability) ->

module.exports = PairController
