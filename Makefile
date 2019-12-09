#!/usr/bin/make -f

VERSION_FILE := sdk/Sources/sdk/Version.swift
VERSION      := $(shell tagit -p --dryrun)

clean:
	@git checkout "$(VERSION_FILE)"
	@rm -rf .build

test:
	(cd sdk && swift test)

run:
	(cd samples && swift run swiftExamples)

compile:
	cd sdk && swift build

version:
	@printf 'class Version {\n    let version = "%s"\n}\n' "$(VERSION)" > "$(VERSION_FILE)"

publish: compile test version
	git commit -am "Incremented version." \
		&& tagit -p \
		&& git push origin master --tags

.PHONY: clean test compile version publish
