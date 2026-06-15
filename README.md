#### SMARTY DISCLAIMER: Subject to the terms of the associated license agreement, this software is freely available for your use. This software is FREE, AS IN PUPPIES, and is a gift. Enjoy your new responsibility. This means that while we may consider enhancement requests, we may or may not choose to entertain requests at our sole and absolute discretion.


# Smarty iOS SDK

The official iOS SDK for accessing [Smarty](https://www.smarty.com) address validation APIs from Swift and Objective-C. Requires Swift 5.0+ and has no external dependencies.

"Getting started with the SmartyStreets iOS SDK" (Click to play on YouTube)

[![YouTube](https://img.youtube.com/vi/wdBi019I9Yc/0.jpg)](https://www.youtube.com/watch?v=wdBi019I9Yc)

## Installation

Add the package to your `Package.swift` dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/smartystreets/smartystreets-ios-sdk.git", from: "8.10.17"),
]
```

Then add `SmartyStreets` to your target's dependencies. In Xcode, use **File → Add Package Dependencies** and enter the repository URL.

## Quick Start: US Street Address Validation

```swift
import SmartyStreets

let authId = ProcessInfo.processInfo.environment["SMARTY_AUTH_ID"] ?? ""
let authToken = ProcessInfo.processInfo.environment["SMARTY_AUTH_TOKEN"] ?? ""
let client = ClientBuilder.withBasicAuth(authId: authId, authToken: authToken)
    .buildUsStreetApiClient()

var lookup = USStreetLookup()
lookup.street = "1600 Amphitheatre Parkway"
lookup.city = "Mountain View"
lookup.state = "CA"
lookup.maxCandidates = 3

var error: NSError! = nil
_ = client.sendLookup(lookup: &lookup, error: &error)

if let error = error {
    print("Error: \(error.localizedDescription)")
} else if let candidate = lookup.result.first {
    print("ZIP: \(candidate.components?.zipCode ?? "")")
}
```

## Quick Start: US Autocomplete Pro

```swift
let client = ClientBuilder.withBasicAuth(authId: authId, authToken: authToken)
    .buildUSAutocompleteProApiClient()

var lookup = USAutocompleteProLookup().withSearch(search: "4770 Lincoln")
lookup.maxResults = 10
lookup.addPreferState(state: "IL")

var error: NSError! = nil
_ = client.sendLookup(lookup: &lookup, error: &error)

if let suggestions = lookup.result?.suggestions {
    for s in suggestions {
        print("\(s.streetLine ?? "") \(s.city ?? ""), \(s.state ?? "") \(s.zipcode ?? "")")
    }
}
```

## Supported APIs

| API | Lookup Type | Build Method | Example |
| --- | --- | --- | --- |
| [US Street](https://www.smarty.com/docs/cloud/us-street-api) | `USStreetLookup` | `buildUsStreetApiClient()` | [example](samples/Sources/swiftExamples/USStreetSingleAddressExample.swift) |
| [US Zipcode](https://www.smarty.com/docs/cloud/us-zipcode-api) | `USZipCodeLookup` | `buildUsZIPCodeApiClient()` | [example](samples/Sources/swiftExamples/USZipCodeSingleLookupExample.swift) |
| [US Autocomplete Pro](https://www.smarty.com/docs/cloud/us-autocomplete-pro-api) | `USAutocompleteProLookup` | `buildUSAutocompleteProApiClient()` | [example](samples/Sources/swiftExamples/USAutocompleteProExample.swift) |
| [US Autocomplete](https://www.smarty.com/docs/apis/us-autocomplete-v2) | `USAutocompleteLookup` | `buildUSAutocompleteApiClient()` | [example](samples/Sources/swiftExamples/USAutocompleteExample.swift) |
| [US Extract](https://www.smarty.com/docs/cloud/us-extract-api) | `USExtractLookup` | `buildUsExtractApiClient()` | [example](samples/Sources/swiftExamples/USExtractExample.swift) |
| [US Enrichment](https://www.smarty.com/docs/cloud/us-address-enrichment-api) | `EnrichmentLookup` | `buildUsEnrichmentApiClient()` | [example](samples/Sources/swiftExamples/USEnrichmentExample.swift) |
| [US Reverse Geocoding](https://www.smarty.com/docs/cloud/us-reverse-geo-api) | `USReverseGeoLookup` | `buildUsReverseGeoApiClient()` | [example](samples/Sources/swiftExamples/USReverseGeoExample.swift) |
| [International Street](https://www.smarty.com/docs/cloud/international-street-api) | `InternationalStreetLookup` | `buildInternationalStreetApiClient()` | [example](samples/Sources/swiftExamples/InternationalStreetExample.swift) |
| [International Autocomplete](https://www.smarty.com/docs/cloud/international-address-autocomplete-api) | `InternationalAutocompleteLookup` | `buildInternationalAutocompleteApiClient()` | [example](samples/Sources/swiftExamples/InternationalAutocompleteExample.swift) |
| [International Postal Code](https://www.smarty.com/docs/cloud/international-postal-code-api) | `InternationalPostalCodeLookup` | `buildInternationalPostalCodeApiClient()` | [example](samples/Sources/swiftExamples/InternationalPostalCodeExample.swift) |

## Authentication

Three credential types are available:

- **`ClientBuilder(authId:authToken:)`** — Server-to-server using auth-id and auth-token (passed as query parameters).
- **`ClientBuilder.withBasicAuth(authId:authToken:)`** — HTTP Basic Auth.
- **`ClientBuilder(id:hostname:)`** — Client-side (mobile/browser) authentication using an embedded key and `Referer` hostname. Does not support batch (POST) requests.

```swift
// Server-to-server (query params)
let client = ClientBuilder(authId: authId, authToken: authToken).buildUsStreetApiClient()

// HTTP Basic Auth
let client = ClientBuilder.withBasicAuth(authId: authId, authToken: authToken).buildUsStreetApiClient()

// Client-side with a website key
let client = ClientBuilder(id: embeddedKey, hostname: "yourhost.com").buildUsStreetApiClient()
```

Credentials should be stored in environment variables or a secure keychain — never checked into source control.

## Common Patterns

### Batch Requests

Send up to 100 lookups in a single request (not available with embedded-key credentials):

```swift
let batch = USStreetBatch()
var error: NSError! = nil

_ = batch.add(newAddress: address1, error: &error)
_ = batch.add(newAddress: address2, error: &error)

_ = client.sendBatch(batch: batch, error: &error)
```

### Error Handling

API errors are returned as `NSError` values in the `SmartyErrorDomain`. The `sendLookup(lookup:error:)` family uses the inout pointer pattern for Objective-C compatibility:

```swift
var error: NSError! = nil
_ = client.sendLookup(lookup: &lookup, error: &error)

if let error = error {
    print("Domain: \(error.domain)")
    print("Code: \(error.code)")
    print("Description: \(error.localizedDescription)")
}
```

### Retry and Timeout

```swift
let client = ClientBuilder.withBasicAuth(authId: authId, authToken: authToken)
    .retryAtMost(maxRetries: 5)
    .withMaxTimeout(maxTimeout: 10000)
    .buildUsStreetApiClient()
```

### Proxy

```swift
let client = ClientBuilder.withBasicAuth(authId: authId, authToken: authToken)
    .withProxy(host: "proxy.example.com", port: 8080)
    .buildUsStreetApiClient()
```

### Custom Headers

```swift
let client = ClientBuilder.withBasicAuth(authId: authId, authToken: authToken)
    .withCustomHeader(key: "X-Custom-Header", value: "value")
    .buildUsStreetApiClient()
```

Note: custom `User-Agent` values are appended to the SDK's default (`smartystreets (sdk:ios@<version>)`) rather than replacing it. All other headers replace as expected.

### Feature Flags

Optional US Street features can be enabled on the builder:

```swift
let client = ClientBuilder.withBasicAuth(authId: authId, authToken: authToken)
    .withFeatureComponentAnalysis()
    .withFeatureIanaTimeZone()
    .buildUsStreetApiClient()
```

## Objective-C Interop

All public classes are marked `@objcMembers` and inherit from `NSObject`, so the SDK is usable from Objective-C projects. Requests are synchronous — the SDK uses `DispatchSemaphore` internally. Call from a background queue if you need to avoid blocking the main thread.

## Documentation

Full API documentation is available at [smarty.com/docs/sdk/ios](https://www.smarty.com/docs/sdk/ios).

## License

[Apache 2.0](LICENSE.md)
