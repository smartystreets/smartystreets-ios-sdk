#!/usr/bin/make -f

VERSION_FILE := Sources/SmartyStreets/Version.swift
VERSION      := $(shell tagit -p --dryrun)

clean:
	@git checkout "$(VERSION_FILE)"
	@rm -rf .build

test:
	swift test

run:
	(cd samples && swift run swiftExamples)

# Helper function to run a specific example
# Usage: $(call run-example,ExampleName)
define run-example
	@cp samples/Sources/swiftExamples/main.swift samples/Sources/swiftExamples/main.swift.bak
	@sed -i '' 's/^print(/\/\/ print(/g' samples/Sources/swiftExamples/main.swift
	@sed -i '' 's|^\/\/ print($(1)()\.run())|print($(1)().run())|' samples/Sources/swiftExamples/main.swift
	@(cd samples && swift run swiftExamples) || true
	@mv samples/Sources/swiftExamples/main.swift.bak samples/Sources/swiftExamples/main.swift
endef

# Example targets - run individual examples
example-us-street-single:
	@$(call run-example,USStreetSingleAddressExample)

example-us-street-multiple:
	@$(call run-example,USStreetMultipleAddressExample)

example-us-street-component-analysis:
	@$(call run-example,USStreetComponentAnalysisExample)

example-us-zipcode-single:
	@$(call run-example,USZipCodeSingleLookupExample)

example-us-zipcode-multiple:
	@$(call run-example,USZipCodeMultipleLookupsExample)

example-us-autocomplete-pro:
	@$(call run-example,USAutocompleteProExample)

example-us-extract:
	@$(call run-example,USExtractExample)

example-international-street:
	@$(call run-example,InternationalStreetExample)

example-international-autocomplete:
	@$(call run-example,InternationalAutocompleteExample)

example-international-postal-code:
	@$(call run-example,InternationalPostalCodeExample)

example-us-reverse-geo:
	@$(call run-example,USReverseGeoExample)

example-us-enrichment:
	@cp samples/Sources/swiftExamples/main.swift samples/Sources/swiftExamples/main.swift.bak
	@sed -i '' 's/^print(/\/\/ print(/g' samples/Sources/swiftExamples/main.swift
	@sed -i '' 's|^\/\/ print(try USEnrichmentExample()\.run())|print(try USEnrichmentExample().run())|' samples/Sources/swiftExamples/main.swift
	@(cd samples && swift run swiftExamples) || true
	@mv samples/Sources/swiftExamples/main.swift.bak samples/Sources/swiftExamples/main.swift

# Run all examples
examples-all:
	@echo "Running all examples..."
	@$(MAKE) example-us-street-single
	@$(MAKE) example-us-street-multiple
	@$(MAKE) example-us-street-component-analysis
	@$(MAKE) example-us-zipcode-single
	@$(MAKE) example-us-zipcode-multiple
	@$(MAKE) example-us-autocomplete-pro
	@$(MAKE) example-us-extract
	@$(MAKE) example-international-street
	@$(MAKE) example-international-autocomplete
	@$(MAKE) example-international-postal-code
	@$(MAKE) example-us-reverse-geo
	@$(MAKE) example-us-enrichment
	@echo "All examples completed!"

compile:
	swift build

version:
	@printf 'class Version {\n    let version = "%s"\n}\n' "$(VERSION)" > "$(VERSION_FILE)"

publish: compile test version
	git commit -am "Incremented version." \
		&& tagit -p \
		&& git push origin master --tags \
		&& git checkout "$(VERSION_FILE)"

.PHONY: clean test compile version publish run examples-all
.PHONY: example-us-street-single example-us-street-multiple example-us-street-component-analysis
.PHONY: example-us-zipcode-single example-us-zipcode-multiple
.PHONY: example-us-autocomplete-pro example-us-extract
.PHONY: example-international-street example-international-autocomplete example-international-postal-code
.PHONY: example-us-reverse-geo example-us-enrichment
