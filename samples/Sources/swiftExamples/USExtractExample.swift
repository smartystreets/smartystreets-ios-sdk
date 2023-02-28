import Foundation
import SmartyStreets

class USExtractExample {
    func run() -> String {
        //            We recommend storing your authentication credentials in environment variables.
        //            for server-to-server requests, use this code:
        //let authId = getEnvironmentVar("SMARTY_AUTH_ID") ?? ""
        //let authToken = getEnvironmentVar("SMARTY_AUTH_TOKEN") ?? ""
        //let client = ClientBuilder(authId:authId, authToken:authToken).buildUsExtractApiClient()
        
        // for client-side requests (browser/mobile), use this code:
        let id = getEnvironmentVar("SMARTY_AUTH_WEB") ?? ""
        let hostname = getEnvironmentVar("SMARTY_AUTH_REFERER") ?? ""
        let client = ClientBuilder(id: id, hostname: hostname).buildUsExtractApiClient()
        
        //            Documentation for input fields can be found at:
        //            https://smartystreets.com/docs/cloud/us-extract-api#http-request-input-fields
        
        let text = "Here is some text.\r\nMy address is 3785 Las Vegs Av." +
        "\r\nLos Vegas, Nevada." +
        "\r\nMeet me at 1 Rosedale Baltimore Maryland, not at 123 Phony Street, Boise Idaho." +
        "\r\nAlso, this is a non-postal example to show how to get to 808 County Road 408 Brady, Tx."
        
        var lookup = USExtractLookup().withText(text: text)
        lookup.aggressive = true
        lookup.addressesHaveLineBreaks = false
        lookup.addressesPerLine = 1
        lookup.match = USExtractLookup.MatchStrategy.enhanced
        var error: NSError! = nil
        
        _ = client.sendLookup(lookup: &lookup, error: &error)
        
        if let error = error {
            let output = """
            Domain: \(error.domain)
            Code: \(error.code)
            Description: \(error.userInfo[NSLocalizedDescriptionKey] ?? "")
            """
            return output
        }
        
        let result = lookup.result
        let metadata = result?.metadata
        var output = "Results: "
        output.append("\nFound \(metadata?.addressCount ?? 0)")
        output.append("\n\(metadata?.verifiedCount ?? 0) of them were valid.\n\n")
        
        let addresses = result?.addresses
        
        output.append("Addresses: \n****************************\n")
        
        if let addresses = addresses {
            for address in addresses {
                print("ADDRESS VERIFIED \(address.verified ?? false)")
                output.append("\n\"\(address.text ?? "")\"\n")
                output.append("\nVerified? \(address.isVerified() ? "YES" : "NO")")
                if address.candidates?.count ?? 0 > 0 {
                    output.append("\nMatches")
                    
                    for candidate in address.candidates! {
                        output.append("\n\(candidate.deliveryLine1 ?? "")")
                        output.append("\n\(candidate.lastline ?? "")\n")
                    }
                } else {
                    output.append("\n")
                }
                output.append("****************************\n")
            }
        }
        return output
    }
}
