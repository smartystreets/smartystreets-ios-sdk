#### SMARTY DISCLAIMER: Subject to the terms of the associated license agreement, this software is freely available for your use. This software is FREE, AS IN PUPPIES, and is a gift. Enjoy your new responsibility. This means that while we may consider enhancement requests, we may or may not choose to entertain requests at our sole and absolute discretion.

# smartystreets-ios-sdk

The official client libraries for accessing SmartyStreets APIs from Swift and Objective-C.

---

"Getting started with the SmartyStreets iOS SDK" (Click to play on YouTube)

[![YouTube](https://img.youtube.com/vi/wdBi019I9Yc/0.jpg)](https://www.youtube.com/watch?v=wdBi019I9Yc)

---

You may have noticed this page is curiously sparse. Don't panic, read the [documentation](https://smartystreets.com/docs/sdk/ios).

## US Enrichment — Business API and ETag support

The US Enrichment client supports the `business` dataset for company information lookups:

- **Business Summary** — `USEnrichmentClient.sendBusinessLookup(smartyKey:error:)`, `sendBusinessLookup(inputLookup:error:)`, or `sendBusinessLookup(lookup:error:)`. Returns `[BusinessSummaryResult]`, each containing the companies (`BusinessEntry`) associated with a smartyKey or address.
- **Business Detail** — `USEnrichmentClient.sendBusinessDetailLookup(businessId:error:)` or `sendBusinessDetailLookup(lookup:error:)`. Returns a single `BusinessDetailResult` whose `attributes` field carries ~194 company-specific fields.

ETag round-trip is supported on all enrichment lookups:

- `setRequestEtag(etag:)` sends the given value as the `Etag` request header.
- `getResponseEtag()` returns the server's current ETag after a successful (200) response.
- On 304, the resulting `NSError` carries the refreshed ETag in `userInfo[SmartyErrors.ResponseEtagKey]` so callers can update their cache key.

The legacy `getEtag()` / `setEtag()` accessors remain as aliases for `getRequestEtag()` / `setRequestEtag()`.

### Behavior change: client-side validation

All US Enrichment `sendXxxLookup` methods now fail fast with a `FieldNotSetError` (`SmartyErrors.SSErrors.FieldNotSetError`) when the lookup has no `smartyKey`, `street`, or `freeform` set (whitespace-only values count as unset). Previously these calls would proceed to the network with a malformed URL. Callers that relied on the old behavior should populate at least one of those fields before sending.

[Apache 2.0 License](LICENSE.md)
