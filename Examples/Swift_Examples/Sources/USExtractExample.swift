import Foundation
import SmartystreetsSDK

class USExtractExample {
    func run() -> String {
        let client = SSClientBuilder(authId: MyCredentials.AuthId,
                                     authToken: MyCredentials.AuthToken).buildUsExtractApiClient()
        
        let text = "Here is some text.\r\nMy address is 3785 Las Vegs Av." +
        "\r\nLos Vegas, Nevada." +
        "\r\nMeet me at 1 Rosedale Baltimore Maryland, not at 123 Phony Street, Boise Idaho."
        
        let lookup = SSUSExtractLookup(text: text)
        
        do {
            try client?.send(lookup)
        } catch let error as NSError {
            print(String(format: "Domain: %@", error.domain))
            print(String(format: "Error Code: %i", error.code))
            print(String(format: "Description: %@", error.localizedDescription))
            return "Error sending request"
        }
        
        let result: SSUSExtractResult = (lookup?.result)!
        let metadata = result.metadata
        var output = String(format: "Found %i addresses.\n", (metadata?.addressCount)!)
        output += String(format: "%i of them were valid.\n\n", (metadata?.verifiedCount)!)
        
        let addresses = result.addresses
        
        output += "Addresses: \n**********************\n"
        
        for address in addresses! {
            output += "\n\"" + address.text + "\"\n"
            output += "\nVerified? " + "\(address.isVerified())"
            if (address.candidates.count > 0) {
                output += "\nMatches:"
                
                for candidate in address.candidates {
                    output += "\n" + candidate.deliveryLine1
                    output += "\n" + candidate.lastline + "\n"
                }
            }
            else {
                output += "\n"
            }
            
            output += "**********************\n"
        }
        
        return output
    }
}
