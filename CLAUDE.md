# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build and Test Commands

```bash
make test              # Run XCTest suite (swift test)
make compile           # Build the package (swift build)
make clean             # Reset build artifacts
make run               # Run all sample examples
make publish           # compile + test + version + git tag + push
```

Run a single test class or method:
```bash
swift test --filter USStreetClientTests
swift test --filter USStreetClientTests/testSingleAddressGetsRequestParameters
```

Run individual examples (requires `SMARTY_AUTH_ID` and `SMARTY_AUTH_TOKEN` env vars):
```bash
make example-us-street-single
make example-us-street-multiple
make example-us-zipcode-single
make example-international-street
make example-us-enrichment
make examples-all      # Run all examples
```

## Architecture Overview

This is a Swift SDK for SmartyStreets address validation APIs. Swift 5.0+ via Swift Package Manager. No external dependencies.

### Sender Chain (Decorator Pattern)

The SDK uses a decorator pattern for HTTP request processing. The chain is built in `ClientBuilder.buildSender()`:

```
HttpSender (URLSession transport, synchronous via DispatchSemaphore)
  → StatusCodeSender (maps HTTP status codes to NSError)
    → RetrySender (retry with exponential backoff, max 10s between retries)
      → SigningSender (adds auth credentials via SmartyCredentials.sign())
        → CustomHeaderSender (injects headers including User-Agent)
          → URLPrefixSender (sets API endpoint)
            → LicenseSender (adds license query params)
              → CustomQuerySender (adds custom query parameters)
```

Each sender wraps an inner sender and implements `SmartySender.sendRequest(request:error:)`.

### API Client Structure

Nine API clients (USStreet, USZipCode, USAutocompletePro, USExtract, USReverseGeo, USEnrichment, InternationalStreet, InternationalAutocomplete, InternationalPostalCode). Each follows this pattern:
- `[Name]Client` - Main client class with `sendLookup()` or `sendBatch()` methods
- `[Name]Lookup` - Input model containing request parameters
- `[Name]Candidate/Result` - Response model(s)
- `[Name]Serializer` - JSON serialization using Swift Codable (extends `SmartySerializer`)

### ClientBuilder (Factory Pattern)

Single entry point for creating API clients with fluent/chainable configuration:

```swift
let client = ClientBuilder(authId: id, authToken: token)
    .retryAtMost(maxRetries: 3)
    .withMaxTimeout(maxTimeout: 5000)
    .buildUsStreetApiClient()
```

Auth options:
- `ClientBuilder(authId:authToken:)` - Server-to-server with static credentials (query params)
- `ClientBuilder(id:hostname:)` - Client-side with shared/web credentials (Referer header)
- `ClientBuilder.withBasicAuth(authId:authToken:)` - HTTP Basic Auth (Authorization header)
- `ClientBuilder(signer:)` - Custom `SmartyCredentials` implementation

Feature flags enable optional API capabilities and can be chained (comma-separated internally via `withCustomCommaSeparatedQuery`):
- `withFeatureComponentAnalysis()` - US Street component analysis
- `withFeatureIanaTimeZone()` - IANA timezone data in US Street metadata

User-Agent handling: default is `"smartystreets (sdk:ios@{version})"`. Calling `withCustomHeader(key: "User-Agent", value:)` **appends** to the default rather than replacing it (other headers replace normally).

### Error Handling

Uses `NSError` with `SmartyErrorDomain`. Error handling uses inout pointer pattern for Objective-C compatibility:

```swift
var error: NSError! = nil
_ = client.sendLookup(lookup: &lookup, error: &error)
if let error = error { /* handle */ }
```

### Key Conventions

- All public classes use `@objcMembers` and inherit from `NSObject` for Objective-C interop
- Requests are synchronous (uses `DispatchSemaphore` internally in `HttpSender`)
- Single lookups use GET with query params; batches use POST with JSON body (max 100 per batch)
- Results are stored in the lookup's `result` property after sending
- Version is managed in `Sources/SmartyStreets/Version.swift` and auto-updated by `make publish` via `tagit`

### USEnrichment API (Most Complex)

Unlike other APIs, USEnrichment has multiple lookup/result type pairs handled by a single client:
- `sendPropertyPrincipalLookup()` → `[PrincipalResult]`
- `sendGeoReferenceLookup()` → `[GeoReferenceResult]`
- `sendRiskLookup()` → `[RiskResult]`
- `sendSecondaryLookup()` / `sendSecondaryCountLookup()` → `[SecondaryResult]` / `[SecondaryCountResult]`

Each has a dedicated serializer and can be called with either a `smartyKey` string or an `EnrichmentLookup` object.

### CI

GitHub Actions: `.github/workflows/test.yml` (runs `make test` on all branches), `.github/workflows/release.yml` (creates GitHub releases on tags).

### Test Structure

Tests mirror the source structure under `Tests/SmartyStreetsTests/`. Key mock classes in `Mocks/`:
- `MockSender` / `RequestCapturingSender` - Stub/capture HTTP requests
- `MockSleeper` - Tracks sleep durations for retry testing
- `MockCrashingSender` - Tests error scenarios
- `MockSerializer` - Serialization mocking
