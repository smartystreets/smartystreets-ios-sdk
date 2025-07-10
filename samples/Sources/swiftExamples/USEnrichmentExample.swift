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
        let authId = getEnvironmentVar("SMARTY_AUTH_ID") ?? ""
        let authToken = getEnvironmentVar("SMARTY_AUTH_TOKEN") ?? ""
        let client = ClientBuilder(authId: authId, authToken: authToken).buildUsEnrichmentApiClient()
        
        // for client-side requests (browser/mobile), use this code:
//         let id = getEnvironmentVar("SMARTY_AUTH_WEB") ?? ""
//         let hostname = getEnvironmentVar("SMARTY_AUTH_REFERER") ?? ""
//         let client = ClientBuilder(id: id, hostname: hostname).buildUsEnrichmentApiClient()

        let smartyKey = ""
        // Comment the above line, and uncomment the below line to make a call with ONLY a SmartyKey
        //let smartyKey = "325023201"
        
        let lookup = EnrichmentLookup()
        lookup.setStreet(street: "56 Union Ave")
        lookup.setCity(city: "Somerville")
        lookup.setState(state: "NJ")
        lookup.setZipcode(zipcode: "08876")
        
        // Uncomment the below line to make a call with SmartyKey:
        //lookup.setSmartyKey(smarty_key: "325023201")
        
        // Uncomment the below line to set the freeform field on a lookup:
        //lookup.setFreeform(freeform: "56 Union Ave Somerville NJ 08876")
        
        // Uncomment the below line to include an attribute in a lookup:
        //lookup.addIncludeAttribute(attribute: "census_tract")
        
        // Uncomment the below line to exclude an attribute from a lookup:
        //lookup.addExcludeAttribute(attribute: "census_tract")
        
        // Uncomment the below line to add an Etag header to a lookup:
        //lookup.setEtag(etag: "AUBAGDQDAIGQYCYC")
        
        // Uncomment the below line to add a custom parameter to a lookup:
        //lookup.addCustomParameter(parameter: "parameter", value: "value")
        
        let lookupType = "geo-reference"
        
        if (smartyKey == "") {
            if lookupType.lowercased() == "principal" {
                let results = client.sendPropertyPrincipalLookup(inputLookup: lookup, error: &error)
                return try self.outputPrincipalResults(results: [results?[0].attributes])
            } else if lookupType.lowercased() == "financial" {
                let results = client.sendPropertyFinancialLookup(inputLookup: lookup, error: &error)
                return try self.outputFinancialResults(results: [results?[0].attributes])
            } else if lookupType.lowercased() == "geo-reference" {
                let results = client.sendGeoReferenceLookup(inputLookup: lookup, error: &error)
                return try self.outputGeoReferenceResults(results: [results?[0].attributes])
            } else if lookupType.lowercased() == "secondary" {
                let results = client.sendSecondaryLookup(inputLookup: lookup, error: &error)
                return try self.outputSecondaryResults(results: [results?[0]])
            } else if lookupType.lowercased() == "secondary-count" {
                let results = client.sendSecondaryCountLookup(inputLookup: lookup, error: &error)
                return try self.outputSecondaryCountResults(results: [results?[0]])
            }
        // The following calls are made using ONLY a smarty key, and are not capable of accepting other parameters.
        // Use a 'lookup' call, like those above, to make an API call with additional parameters.
        } else if lookupType.lowercased() == "principal" {
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
