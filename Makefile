#!/usr/bin/make -f

PLIST_FILE     := Sources/Info.plist
PODSPEC_FILE   := SmartystreetsSDK.podspec
VERSION        := $(shell tagit -p --dry-run)

clean:
	rm -rf ./Output

test:
	xcodebuild test -scheme SmartystreetsSDK -destination "platform=iOS Simulator,name=iPhone 8,OS=11.4"

publish:
	pod trunk push "$(PODSPEC_FILE)"

##########################################################

version:
	sed -i "s/0\.0\.0/$(VERSION)/g" "$(PLIST_FILE)"
	sed -i "s/0\.0\.0/$(VERSION)/g" "$(PODSPEC_FILE)"

workspace:
	docker-compose run sdk /bin/sh

release: version clean test
	git add "$(PLIST_FILE)" "$(PODSPEC_FILE)" \
		&& git commit -m "Incremeted version to $(VERSION)." \
		&& tagit -p
		&& docker-compose run sdk make publish \
		&& git push origin --tags

.PHONY: clean test publish version workspace release
