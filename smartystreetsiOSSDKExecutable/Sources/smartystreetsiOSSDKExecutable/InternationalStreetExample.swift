import Foundation
import smartystreetsiOSSDKCore

class InternationalStreetExample {
    func run() -> String {
        //        let authId = ProcessInfo.processInfo.environment["SMARTY_AUTH_ID"]
        //        let authToken = ProcessInfo.processInfo.environment["SMARTY_AUTH_TOKEN"]
        //        let client = ClientBuilder(authId: authId ?? "", authToken: authToken ?? "").buildInternationalStreetApiClient()
        let authId = "ID"
        let authToken = "TOKEN"
        let client = ClientBuilder(authId: authId, authToken: authToken).buildInternationalStreetApiClient()
        
        // Documentation for input fields can be found at:
        // https://smartystreets.com/docs/cloud/international-street-api#http-input-fields
        
        var lookup = InternationalStreetLookup()
        lookup.inputId = "ID-8675309"
        lookup.organization = "John Doe"
        lookup.address1 = "Rua Padre Antonio D'Angelo 121"
        lookup.address2 = "Casa Verde"
        lookup.locality = "Sao Paulo"
        lookup.administrativeArea = "SP"
        lookup.country = "Brazil"
        lookup.postalCode = "02516-050"
        lookup.enableGeocode(geocode: true)
        
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
        
        let results:[InternationalStreetCandidate] = lookup.result ?? []
        var output = "Results:\n"
        
        if results.count == 0 {
            return "Error. Address is not valid"
        }
        
        let candidate = results[0]
        if let analysis = candidate.analysis, let metadata = candidate.metadata {
            output.append("""
                \nAddress is \(analysis.verificationStatus ?? "")
                \nAddress precision: \(analysis.addressPrecision ?? "")\n
                \nFirst Line: \(candidate.address1 ?? "")
                \nSecond Line: \(candidate.address2 ?? "")
                \nThird Line: \(candidate.address3 ?? "")
                \nFourth Line: \(candidate.address4 ?? "")
                \nLatitude: \(metadata.latitude ?? 0)
                \nLongitude: \(metadata.longitude ?? 0)
                """)
        }
        return output
    }
}
