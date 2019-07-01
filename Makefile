#!/usr/bin/make -f

clean:
	rm -rf .build

test:
    swift test

.PHONY: clean test
