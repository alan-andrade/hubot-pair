# Hubot-pair

This will help you pair with other developers making sure you're not
interrupting anybody. This is the craigslist for pairing :)

## How does it work?

As the person that is available to pair, you need to tell hubot you're
available for a certain amount of time.

```shell
hubot pairme 60
```

If you are the person looking for a pair, ask hubot for other people
availability.

```shell
hubot pairme

# > jake[15], fin[30], iceking[1]
# > beemo-marceline
```

If you end up pairing with somebody, let hubot know.

```shell
hubot pairme with jake
```

## Test

`npm test`

# TODO

- Being able to unpair people
- Let people know when the time is up
- Use a different storage mechanism
- Statitics capabilities

# Contributing

Send your pull request along with some tests.

# Maintainers
- @alan-andrade
