import Foundation
import SmartyStreets

class USEnrichmentBusinessSearchExample {
    var error: NSError! = nil

    func run() throws -> String {
        //            The appropriate license values to be used for your subscriptions
        //            can be found on the Subscriptions page of the account dashboard.
        //            https://www.smartystreets.com/docs/cloud/licensing
        //            We recommend storing your authentication credentials in environment variables.
        //            for client-side requests (browser/mobile), use this code:
        //let id = getEnvironmentVar("SMARTY_AUTH_WEB") ?? ""
        //let hostname = getEnvironmentVar("SMARTY_AUTH_REFERER") ?? ""
        //let client = ClientBuilder(id: id, hostname: hostname).buildUsEnrichmentApiClient()

        // for server-to-server requests, use this code:
        let authId = getEnvironmentVar("SMARTY_AUTH_ID") ?? ""
        let authToken = getEnvironmentVar("SMARTY_AUTH_TOKEN") ?? ""
        let client = ClientBuilder.withBasicAuth(authId: authId, authToken: authToken).buildUsEnrichmentApiClient()

        let smartyKey = "325023201"

        let lookup = EnrichmentLookup()
        lookup.setSmartyKey(smartyKey)
        lookup.setBusinessName(businessName: "delta air")
        lookup.setCity(city: "atlanta")

        let summaries = client.sendBusinessLookup(inputLookup: lookup, error: &error)

        if let error = error {
            return self.errorOutput(error)
        }

        guard let summaries = summaries,
              let firstSummary = summaries.first,
              let firstBusiness = firstSummary.businesses?.first,
              let businessId = firstBusiness.businessId else {
            return "No matching businesses found."
        }

        var output = "Matching businesses: \n"
        output.append(try self.encode(summaries))
        output.append("\n******************************\n")

        let detail = client.sendBusinessDetailLookup(businessId: businessId, error: &error)

        if let error = error {
            return self.errorOutput(error)
        }

        output.append("Business detail for \(businessId): \n")
        output.append(try self.encode(detail))
        output.append("\n******************************\n")

        return output
    }

    private func encode<T: Encodable>(_ value: T) throws -> String {
        let encoder = JSONEncoder()
        let jsonData = try encoder.encode(value)
        return String(data: jsonData, encoding: .utf8) ?? "{}"
    }

    private func errorOutput(_ error: NSError) -> String {
        let output = """
        Domain: \(error.domain)
        Error Code: \(error.code)
        Description:\n\(error.userInfo[NSLocalizedDescriptionKey] as! NSString)
        """
        NSLog(output)
        return output
    }
}
