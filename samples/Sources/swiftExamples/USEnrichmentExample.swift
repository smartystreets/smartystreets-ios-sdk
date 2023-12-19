import Foundation
import SmartyStreets

class USEnrichmentExample{
    func run() -> String {
        let client = ClientBuilder(id: "KEY", hostname: "hostname").withLicenses(["us-rooftop-geocoding-cloud"])
            .buildUsEnrichmentApiClient()
        
        var error:NSError! = nil

        let smartyKey = "7"
        
        if lookupType.text.lowercased() == "principal" {
            var results = client.sendPropertyPrincipalLookup(smartyKey: smartyKey, error: error)
            return self.outputPrincipalResults(results)
        } else if lookup.text.lowercased() == "financial" {
            var results = client.sendPropertyFinancialLookup(smartyKey: smartyKey, error: error)
            return self.outputFinancialResults(results)
        }
    }
    
    func outputFinancialResults(results: [FinancialAttributes]) -> String {
        if let error = error {
            let output = """
            Domain: \(error.domain)
            Error Code: \(error.code)
            Description:\n\(error.userInfo[NSLocalizedDescriptionKey] as! NSString)
            """
            NSLog(output)
            return output
        }
        
        var output = "Results: \n"
        
        if results == nil {
            return "\nNo Result Found\n"
        }
        
        for result in results {
            let jsonData = try encoder.encode(result)
            let jsonString = String(data: jsonData, encoding: .utf8)
            output.append(jsonString)
            output.append("\n******************************\n")
        }
        
        output.append("\n******************************\n")

        return output
    }
    
    func outputPrincipalResults(results: [PrincipalAttributes]) -> String {
        if let error = error {
            let output = """
            Domain: \(error.domain)
            Error Code: \(error.code)
            Description:\n\(error.userInfo[NSLocalizedDescriptionKey] as! NSString)
            """
            NSLog(output)
            return output
        }
        
        var output = "Results: \n"
        
        if results == nil {
            return "\nNo Result Found\n"
        }
        
        for result in results {
            let jsonData = try encoder.encode(result)
            let jsonString = String(data: jsonData, encoding: .utf8)
            output.append(jsonString)
            output.append("\n******************************\n")
        }
        
        output.append("\n******************************\n")

        return output
    }
}