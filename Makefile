#!/usr/bin/make -f

VERSION_FILE := Sources/smartystreets-ios-sdk/Version.swift
VERSION      := $(shell tagit -p --dryrun)

clean:
	@git checkout "$(VERSION_FILE)"
	@rm -rf .build

test:
	swift test

compile: clean
	swift build

version:
	@printf 'class Version {\n    let version = "%s"\n}\n' "$(VERSION)" > "$(VERSION_FILE)"

publish: compile test version
	git commit -am "Incremented version." \
		&& tagit -p \
		&& git push origin master --tags

.PHONY: clean test compile version publish
