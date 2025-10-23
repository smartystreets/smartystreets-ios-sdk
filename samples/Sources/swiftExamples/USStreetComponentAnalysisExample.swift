import Foundation
import SmartyStreets

class USStreetComponentAnalysisExample {
    func run() -> String {
        // for client-side requests (browser/mobile), use this code:
        // let id = getEnvironmentVar("SMARTY_AUTH_WEB") ?? ""
        // let hostname = getEnvironmentVar("SMARTY_AUTH_REFERER") ?? ""
        // let client = ClientBuilder(id: id, hostname: hostname).buildUsStreetApiClient()
        
        // for server-to-server requests, use this code:
        let authId = getEnvironmentVar("SMARTY_AUTH_ID") ?? ""
        let authToken = getEnvironmentVar("SMARTY_AUTH_TOKEN") ?? ""
        let client = ClientBuilder(authId:authId, authToken:authToken)
            .withFeatureComponentAnalysis()
            .buildUsStreetApiClient()

        var lookup = USStreetLookup()
        lookup.street = "1 Rosedale"
        lookup.secondary = "APT 2"
        lookup.city = "Baltimore"
        lookup.state = "MD"
        lookup.zipCode = "21229"
        lookup.matchStrategy = "enhanced" // Enhanced matching is required to return component analysis results.

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
            return ""
        }
        
        // Here is an example of how to access the result of component analysis.
        let candidate = results[0]
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try encoder.encode(candidate.analysis?.components)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            return "Component Analysis Results:\n\(jsonString)"
        } catch {
            return "Error encoding JSON: \(error)" 
        }
    }
}

