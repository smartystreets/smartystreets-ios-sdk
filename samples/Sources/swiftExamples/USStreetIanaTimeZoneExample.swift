import Foundation
import SmartyStreets

class USStreetIanaTimeZoneExample {
    func run() -> String {
        let authId = getEnvironmentVar("SMARTY_AUTH_ID") ?? ""
        let authToken = getEnvironmentVar("SMARTY_AUTH_TOKEN") ?? ""
        let client = ClientBuilder.withBasicAuth(authId: authId, authToken: authToken)
            .withFeatureIanaTimeZone()
            .buildUsStreetApiClient()

        var lookup = USStreetLookup()
        lookup.street = "1 Rosedale"
        lookup.city = "Baltimore"
        lookup.state = "MD"
        lookup.zipCode = "21229"
        lookup.matchStrategy = "enhanced"

        var error: NSError! = nil
        _ = client.sendLookup(lookup: &lookup, error: &error)

        if let error = error {
            return """
            Domain: \(error.domain)
            Error Code: \(error.code)
            Description: \(error.userInfo[NSLocalizedDescriptionKey] as! NSString)
            """
        }

        let results:[USStreetCandidate] = lookup.result

        if results.count == 0 {
            return "No results found."
        }

        let candidate = results[0]
        let metadata = candidate.metadata

        return """
        Traditional Timezone Fields:
          timeZone: \(metadata?.timeZone ?? "")
          utcOffset: \(metadata?.utcOffset ?? 0)
          obeysDst: \(metadata?.obeysDst ?? false)

        IANA Timezone Fields:
          ianaTimeZone: \(metadata?.ianaTimeZone ?? "")
          ianaUtcOffset: \(metadata?.ianaUtcOffset ?? 0)
          ianaObeysDst: \(metadata?.ianaObeysDst ?? false)
        """
    }
}
