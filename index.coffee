# Description:
#   Find a pair without bothering anybody
#
# Commands:
#   pairme - List available pairs
#   pairme timeInMinutes - Signs you up.
#   pairme with {user_name} - Start a pairing session with user
#
# Author:
#   alan-andrade

pairme = require './lib/pairme'
controller = new pairme.Controller

module.exports = (robot) ->
  robot.hear /pairme$/, (msg) ->
    msg.reply(controller.display())

  robot.hear /pairme (\d+?)/, (msg) ->
    if time = msg.match[1]
      user_name = msg.envelope.user.name
      controller.add user_name, +time
      msg.reply('youre all set.')

  robot.hear /pairme with (\w+?)$/i, (msg) ->
    if pair_name = msg.match[1]
      user_name = msg.envelope.user.name
      controller.pair(user_name, pair_name)
      msg.reply(controller.display())
