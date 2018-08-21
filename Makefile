#!/usr/bin/make -f

SOURCE_VERSION := 7.5
PLIST_FILE = Sources/Info.plist
PODSPEC_FILE = SmartystreetsSDK.podspec

clean:
	rm -rf ./Output

test:
	xcodebuild test -scheme SmartystreetsSDK -destination "platform=iOS Simulator,name=iPhone 8,OS=11.4"

local-publish: clean
	sed -i "s/0\.0\.0/$(shell git describe)/g" "$(PLIST_FILE)"
	sed -i "s/0\.0\.0/$(shell git describe)/g" "$(PODSPEC_FILE)"
	-pod trunk push "$(PODSPEC_FILE)"

dependencies: 
	gem install cocoapods

version:
	$(eval PREFIX := $(SOURCE_VERSION).)
	$(eval CURRENT := $(shell git describe 2>/dev/null))
	$(eval EXPECTED := $(PREFIX)$(shell git tag -l "$(PREFIX)*" | wc -l | xargs expr -1 +))
	$(eval INCREMENTED := $(PREFIX)$(shell git tag -l "$(PREFIX)*" | wc -l | xargs expr 0 +))
	@if [ "$(CURRENT)" != "$(EXPECTED)" ]; then git tag -a "$(INCREMENTED)" -m "" 2>/dev/null || true; fi

###################################################################################

publish: version
	git push origin --tags 
	-docker-compose run sdk make local-publish
	git checkout "$(PODSPEC_FILE)"
	git checkout "$(PLIST_FILE)"
