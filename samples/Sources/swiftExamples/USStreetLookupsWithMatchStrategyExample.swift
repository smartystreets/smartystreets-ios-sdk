import Foundation
import SmartyStreets

class USStreetLookupsWithMatchStrategyExample {
    func run() -> String {
        // for client-side requests (browser/mobile), use this code:
        //let id = getEnvironmentVar("SMARTY_AUTH_WEB") ?? ""
        //let hostname = getEnvironmentVar("SMARTY_AUTH_REFERER") ?? ""
        //let client = ClientBuilder(id: id, hostname: hostname).buildUsStreetApiClient()

        // for server-to-server requests, use this code:
        let authId = getEnvironmentVar("SMARTY_AUTH_ID") ?? ""
        let authToken = getEnvironmentVar("SMARTY_AUTH_TOKEN") ?? ""
        let client = ClientBuilder.withBasicAuth(authId: authId, authToken: authToken).buildUsStreetApiClient()

        let batch = USStreetBatch()
        var error: NSError! = nil

        // Each address is run through all three match strategies so you can compare how
        // 'strict', 'enhanced', and 'invalid' each handle a valid, an invalid, and an
        // ambiguous address.
        //   - strict:   only returns candidates that are valid, mailable addresses.
        //   - enhanced: returns a more comprehensive dataset (requires a US Core or Rooftop license).
        //   - invalid:  most permissive; always returns at least one candidate (a best-guess standardization).
        // Documentation for input fields: https://smartystreets.com/docs/us-street-api#input-fields
        let addresses = [
            (label: "valid (real, deliverable)",    street: "1600 Amphitheatre Pkwy", city: "Mountain View", state: "CA", zip: "94043"),
            (label: "invalid (no such address)",    street: "9999 W 1150 S",          city: "Provo",         state: "UT", zip: "84601"),
            (label: "ambiguous (missing ZIP/unit)", street: "1 Rosedale St",          city: "Baltimore",     state: "MD", zip: ""),
        ]
        let strategies = ["strict", "enhanced", "invalid"]

        // parallel metadata for each lookup, in the order they are added to the batch
        var cases: [(label: String, address: String, strategy: String)] = []

        for address in addresses {
            for strategy in strategies {
                let lookup = USStreetLookup()
                lookup.street = address.street
                lookup.city = address.city
                lookup.state = address.state
                lookup.zipCode = address.zip
                lookup.matchStrategy = strategy
                lookup.maxCandidates = 10 // allow ambiguous addresses to return more than one match
                _ = batch.add(newAddress: lookup, error: &error)
                cases.append((address.label, "\(address.street), \(address.city), \(address.state)", strategy))
            }
        }

        if let error = error {
            return "Error building batch -> Code: \(error.code) Description: \(error.userInfo[NSLocalizedDescriptionKey] as! NSString)"
        }

        _ = client.sendBatch(batch: batch, error: &error)

        if let error = error {
            return "Error sending batch -> Code: \(error.code) Description: \(error.userInfo[NSLocalizedDescriptionKey] as! NSString)"
        }

        let lookups: [USStreetLookup] = batch.allLookups as! [USStreetLookup]
        let separator = String(repeating: "=", count: 70)
        var output = ""
        var lastAddress = ""

        for i in 0..<batch.count() {
            let c = cases[i]

            if c.address != lastAddress {
                output.append("\n\(separator)\n")
                output.append(" Address: \(c.address)  [\(c.label)]\n")
                output.append("\(separator)\n")
                lastAddress = c.address
            }

            let candidates: [USStreetCandidate] = lookups[i].result
            output.append("\n--- '\(c.strategy)' strategy ---\n")

            if candidates.count == 0 {
                output.append("  0 candidates - no match returned under this strategy.\n")
                continue
            }

            output.append("  \(candidates.count) candidate(s):\n")
            for candidate in candidates {
                output.append("    [\(candidate.candidateIndex ?? 0)] \(candidate.deliveryLine1 ?? "")  \(candidate.lastline ?? "")\n")
            }
        }
        return output
    }
}
