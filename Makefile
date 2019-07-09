#!/usr/bin/make -f

VERSION_FILE := smartystreetsiOSSDKCore/Sources/smartystreets-ios-sdk/Version.swift
VERSION      := $(shell tagit -p --dryrun)

clean:
	@git checkout "$(VERSION_FILE)"
	@rm -rf .build

test:
	cd smartystreetsiOSSDKCore && swift test && cd ..

run:
	cd smartystreetsiOSSDKExecutable && swift run && cd ..

compile: clean
	cd smartystreetsiOSSDKCore && swift build && cd ../smartystreetsiOSSDKExecutable && swift build && cd ..

version:
	@printf 'class Version {\n    let version = "%s"\n}\n' "$(VERSION)" > "$(VERSION_FILE)"

publish: compile test version
	git commit -am "Incremented version." \
		&& tagit -p \
		&& git push origin master --tags

.PHONY: clean test compile version publish
