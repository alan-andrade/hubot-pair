NPM_EXECUTABLE_HOME := node_modules/.bin

PATH := ${NPM_EXECUTABLE_HOME}:${PATH}

test: deps generate-js
	@qunit -c lib/src/* -t lib/specs/*

dev: generate-js
	@coffee -wc --bare -o lib src/*.coffee

generate-js:
	@find src -name '*.coffee' | xargs coffee -c -o lib/src
	@find specs -name '*.coffee' | xargs coffee -c -o lib/specs

package:
	@bin/hubot -c hubot
	@chmod 0755 hubot/bin/hubot

remove-js:
	@rm -fr lib/

deps:

.PHONY: all
