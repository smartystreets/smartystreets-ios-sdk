#!/usr/bin/make -f

INCREMENT='patch' # or 'minor' or 'major'

clean:
	rm -rf ./Output

test:
	xcodebuild test -scheme SmartystreetsSDK -destination "platform=iOS Simulator,name=iPhone 7,OS=10.2"

publish: tag
	pod trunk push SmartystreetsSDK.podspec

tag:
	@python tag.py $(INCREMENT)