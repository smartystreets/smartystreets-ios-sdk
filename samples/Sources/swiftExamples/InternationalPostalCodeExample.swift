import Foundation
import SmartyStreets

class InternationalPostalCodeExample {
    func run() -> String {
        //            The appropriate license values to be used for your subscriptions
        //            can be found on the Subscriptions page of the account dashboard.
        //            https://www.smartystreets.com/docs/cloud/licensing
        //            We recommend storing your authentication credentials in environment variables.
        //            for server-to-server requests, use this code:
        let authId = getEnvironmentVar("SMARTY_AUTH_ID_DEV") ?? ""
        let authToken = getEnvironmentVar("SMARTY_AUTH_TOKEN_DEV") ?? ""
        let client = ClientBuilder(authId:authId, authToken:authToken).buildInternationalPostalCodeApiClient()
        
        // // for client-side requests (browser/mobile), use this code:
        // let id = getEnvironmentVar("SMARTY_AUTH_WEB") ?? ""
        // let hostname = getEnvironmentVar("SMARTY_AUTH_REFERER") ?? ""
        // let client = ClientBuilder(id: id, hostname: hostname).buildInternationalPostalCodeApiClient()
        
        // Documentation for input fields can be found at:
        // https://smartystreets.com/docs/cloud/international-postal-code-api
        
        var lookup = InternationalPostalCodeLookup()
        lookup.inputID = "ID-8675309"
        lookup.locality = "Sao Paulo"
        lookup.administrativeArea = "SP"
        lookup.country = "Brazil"
        lookup.postalCode = "02516"
        
        // Uncomment the below line to add a custom parameter to a lookup:
        //lookup.addCustomParameter(parameter: "parameter", value: "value")
        
        var error: NSError! = nil
        
        _ = client.sendLookup(lookup: &lookup, error:&error)
        if let error = error {
            let output = """
            Domain: \(error.domain)
            Error Code: \(error.code)
            Description:\n\(error.userInfo[NSLocalizedDescriptionKey] as! NSString)
            """
            NSLog(output)
            return output
        }
        
        let results: [InternationalPostalCodeCandidate] = lookup.result ?? []
        var output = "Results:\n\n"
        
        if results.count == 0 {
            return "Error. No results found"
        }
        
        for (index, candidate) in results.enumerated() {
            output.append("Candidate: \(index)\n")
            if let inputID = candidate.inputID, !inputID.isEmpty {
                output.append("  \(inputID)\n")
            }
            if let countryIso3 = candidate.countryIso3, !countryIso3.isEmpty {
                output.append("  \(countryIso3)\n")
            }
            if let locality = candidate.locality, !locality.isEmpty {
                output.append("  \(locality)\n")
            }
            if let dependentLocality = candidate.dependentLocality, !dependentLocality.isEmpty {
                output.append("  \(dependentLocality)\n")
            }
            if let doubleDependentLocality = candidate.doubleDependentLocality, !doubleDependentLocality.isEmpty {
                output.append("  \(doubleDependentLocality)\n")
            }
            if let subAdministrativeArea = candidate.subAdministrativeArea, !subAdministrativeArea.isEmpty {
                output.append("  \(subAdministrativeArea)\n")
            }
            if let administrativeArea = candidate.administrativeArea, !administrativeArea.isEmpty {
                output.append("  \(administrativeArea)\n")
            }
            if let superAdministrativeArea = candidate.superAdministrativeArea, !superAdministrativeArea.isEmpty {
                output.append("  \(superAdministrativeArea)\n")
            }
            if let postalCode = candidate.postalCode, !postalCode.isEmpty {
                output.append("  \(postalCode)\n")
            }
            output.append("\n")
        }
        
        return output
    }
}

