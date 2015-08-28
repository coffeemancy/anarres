# Makefile

RUN_OPTS='-vv'

include tasks/*.mk

# just running `make` or `make all` will do `make test`
all: test

test: clean style

run:
	./tasks/scripts/run.sh $(RUN_OPTS)
