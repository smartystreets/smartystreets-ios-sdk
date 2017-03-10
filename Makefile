#!/usr/bin/make -f

test:
	xcodebuild test -scheme SmartystreetsSDK -destination "platform=iOS Simulator,name=iPhone 7,OS=10.2"

clean:
	rm -rf ./Output

publish-patch:
	@python tag.py patch
	pod trunk push SmartystreetsSDK.podspec

publish-minor:
	@python tag.py minor
	pod trunk push SmartystreetsSDK.podspec

publish-major:
	@python tag.py major
	pod trunk push SmartystreetsSDK.podspec