#!/usr/bin/make -f

PLIST_FILE     := Sources/Info.plist
PODSPEC_FILE   := SmartystreetsSDK.podspec
VERSION        := $(shell tagit -p --dry-run)

clean:
	rm -rf ./Output
	git checkout "$(PLIST_FILE)" "$(PODSPEC_FILE)"

test:
	xcodebuild test -scheme SmartystreetsSDK -destination "platform=iOS Simulator,name=iPhone 8,OS=11.4"

version:
	sed -i -E 's/[0-9]+\.[0-9]+\.[0-9]+/$(VERSION)/g' "$(PLIST_FILE)"
	sed -i -E 's/[0-9]+\.[0-9]+\.[0-9]+/$(VERSION)/g' "$(PODSPEC_FILE)"

publish: version
	pod trunk push "$(PODSPEC_FILE)"

##########################################################

workspace:
	docker-compose run sdk /bin/sh

release: clean
	git add "$(PLIST_FILE)" "$(PODSPEC_FILE)" \
		&& git commit -m "Incremeted version to $(VERSION)." \
		&& tagit -p \
		&& git push origin master --tags \
		&& docker-compose run sdk make publish

.PHONY: clean test publish version workspace release
