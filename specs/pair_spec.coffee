PairController = require '../src/pair_controller'

QUnit.module 'Coordinator',
  setup: ->
    @controller = new PairController

test 'queues up a user for 60 minutes by deafult', ->
  @controller.add 'amigo'
  ok @controller.get_free_pairs().length, 'The list is not empty'
  amigo = @controller.get_free_pairs()[0]
  ok amigo.name == 'amigo', 'The name is amigo'
