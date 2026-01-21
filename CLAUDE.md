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

Run individual examples:
```bash
make example-us-street-single
make example-us-street-multiple
make example-us-zipcode-single
make example-international-street
make example-us-enrichment
make examples-all      # Run all examples
```

## Architecture Overview

This is a Swift SDK for SmartyStreets address validation APIs. It supports Swift 5.0+ via Swift Package Manager.

### Sender Chain (Decorator Pattern)

The SDK uses a decorator pattern for HTTP request processing. The chain is built in `ClientBuilder.buildSender()`:

```
HttpSender (URLSession transport)
  → StatusCodeSender (maps HTTP status to errors)
    → RetrySender (retry with exponential backoff)
      → SigningSender (adds auth credentials)
        → URLPrefixSender (sets API endpoint)
          → LicenseSender (adds license headers)
            → CustomQuerySender (custom parameters)
```

Each sender wraps an inner sender and implements `SmartySender.sendRequest(request:error:)`.

### API Client Structure

Each API (USStreet, USZipCode, InternationalStreet, etc.) follows this pattern:
- `[Name]Client` - Main client class with `sendLookup()` or `sendBatch()` methods
- `[Name]Lookup` - Input model containing request parameters
- `[Name]Candidate/Result` - Response model(s)
- `[Name]Serializer` - JSON serialization (extends `SmartySerializer`)

### ClientBuilder (Factory Pattern)

Single entry point for creating API clients with fluent/chainable configuration:

```swift
let client = ClientBuilder(authId: id, authToken: token)
    .retryAtMost(maxRetries: 3)
    .withMaxTimeout(maxTimeout: 5000)
    .buildUsStreetApiClient()
```

Auth options:
- `ClientBuilder(authId:authToken:)` - Server-to-server with static credentials
- `ClientBuilder(id:hostname:)` - Client-side with shared/web credentials
- `ClientBuilder(signer:)` - Custom `SmartyCredentials` implementation

### Error Handling

Uses `NSError` with `SSErrorDomain`. Error handling uses inout pointer pattern for Objective-C compatibility:

```swift
var error: NSError! = nil
_ = client.sendLookup(lookup: &lookup, error: &error)
if let error = error { /* handle */ }
```

### Key Conventions

- All public classes use `@objcMembers` and inherit from `NSObject` for Objective-C interop
- Requests are synchronous (uses `DispatchSemaphore` internally)
- Single lookups use GET with query params; batches use POST with JSON body
- Results are stored in the lookup's `result` property after sending
