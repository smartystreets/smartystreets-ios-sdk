import Foundation
import SmartyStreets

class USEnrichmentExample{
    var error:NSError! = nil
    
    func run() throws -> String {
        //            The appropriate license values to be used for your subscriptions
        //            can be found on the Subscriptions page of the account dashboard.
        //            https://www.smartystreets.com/docs/cloud/licensing
        //            We recommend storing your authentication credentials in environment variables.
        //            for server-to-server requests, use this code:
        //let authId = getEnvironmentVar("SMARTY_AUTH_ID") ?? ""
        //let authToken = getEnvironmentVar("SMARTY_AUTH_TOKEN") ?? ""
        //let client = ClientBuilder(authId:authId, authToken:authToken).withLicenses(licenses:["us-core-cloud"]).buildUsStreetApiClient()
        
        // for client-side requests (browser/mobile), use this code:
        let id = getEnvironmentVar("SMARTY_AUTH_WEB") ?? ""
        let hostname = getEnvironmentVar("SMARTY_AUTH_REFERER") ?? ""
        let client = ClientBuilder(id: "SMARTY_AUTH_WEB", hostname: "SMARTY_AUTH_REFERER").withLicenses(licenses: ["us-property-data-principal-cloud"])
            .buildUsEnrichmentApiClient()

        let smartyKey = "325023201"
        
        let lookupType = "principal"
        
        if lookupType.lowercased() == "principal" {
            let results = client.sendPropertyPrincipalLookup(smartyKey: smartyKey, error: &error)
            return try self.outputPrincipalResults(results: [results?[0].attributes])
        } else if lookupType.lowercased() == "financial" {
            let results = client.sendPropertyFinancialLookup(smartyKey: smartyKey, error: &error)
            return try self.outputFinancialResults(results: [results?[0].attributes])
        } else if lookupType.lowercased() == "geo-reference" {
            let results = client.sendGeoReferenceLookup(smartyKey: smartyKey, error: &error)
            return try self.outputGeoReferenceResults(results: [results?[0].attributes])
        } else if lookupType.lowercased() == "secondary" {
            let results = client.sendSecondaryLookup(smartyKey: smartyKey, error: &error)
            return try self.outputSecondaryResults(results: [results?[0]])
        } else if lookupType.lowercased() == "secondary-count" {
            let results = client.sendSecondaryCountLookup(smartyKey: smartyKey, error: &error)
            return try self.outputSecondaryCountResults(results: [results?[0]])
        }
        
        return "lookupType unknown"
    }
    
    func outputFinancialResults(results: [FinancialAttributes?]) throws -> String {
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
        
        for result in results {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(result)
            let jsonString = String(data: jsonData, encoding: .utf8)
            output.append(jsonString ?? "[]")
            output.append("\n******************************\n")
        }
        
        output.append("\n******************************\n")

        return output
    }
    
    func outputPrincipalResults(results: [PrincipalAttributes?]) throws -> String {
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
        
        for result in results {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(result)
            let jsonString = String(data: jsonData, encoding: .utf8)
            output.append(jsonString ?? "[]")
            output.append("\n******************************\n")
        }
        
        output.append("\n******************************\n")

        return output
    }
    
    func outputGeoReferenceResults(results: [GeoReferenceAttributes?]) throws -> String {
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
        
        for result in results {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(result)
            let jsonString = String(data: jsonData, encoding: .utf8)
            output.append(jsonString ?? "[]")
            output.append("\n******************************\n")
            }
        
        output.append("\n******************************\n")

        return output
    }
    
    func outputSecondaryResults(results: [SecondaryResult?]) throws -> String {
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
        
        for result in results {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(result)
            let jsonString = String(data: jsonData, encoding: .utf8)
            output.append(jsonString ?? "[]")
            output.append("\n******************************\n")
            }
        
        output.append("\n******************************\n")

        return output
    }
    
    func outputSecondaryCountResults(results: [SecondaryCountResult?]) throws -> String {
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
        
        for result in results {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(result)
            let jsonString = String(data: jsonData, encoding: .utf8)
            output.append(jsonString ?? "[]")
            output.append("\n******************************\n")
            }
        
        output.append("\n******************************\n")

        return output
    }
        
}
