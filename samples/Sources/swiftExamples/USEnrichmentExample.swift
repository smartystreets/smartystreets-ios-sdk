import Foundation
import SmartyStreets

class USEnrichmentExample{
    var error:NSError! = nil
    
    func run() throws -> String {
        let client = ClientBuilder(id: "KEY", hostname: "hostname").withLicenses(licenses: ["us-property-data-principal-cloud"])
            .buildUsEnrichmentApiClient()

        let smartyKey = "7"
        
        let lookupType = "principal"
        
        if lookupType.lowercased() == "principal" {
            guard let results = client.sendPropertyPrincipalLookup(smartyKey: smartyKey, error: &error) else { throw NullError.Null }
            return try self.outputPrincipalResults(results: [results[0].attributes])
        } else if lookupType.lowercased() == "financial" {
            guard let results = client.sendPropertyFinancialLookup(smartyKey: smartyKey, error: &error) else { throw NullError.Null }
            return try self.outputFinancialResults(results: [results[0].attributes])
        } else if lookupType.lowercased() == "geo-reference" {
            guard let results = client.sendGeoReferenceLookup(smartyKey: smartyKey, error: &error) else { throw NullError.Null }
            return try self.outputGeoReferenceResults(results: [results[0].attributes])
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
            do {
                let jsonData = try encoder.encode(result)
                guard let jsonString = String(data: jsonData, encoding: .utf8) else { throw NullError.Null }
                output.append(jsonString)
                output.append("\n******************************\n")
            } catch NullError.Null {
                print("No results found. This means the Smartykey is likely not valid.")
            }
            catch {
            }
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
            do {
                let jsonData = try encoder.encode(result)
                guard let jsonString = String(data: jsonData, encoding: .utf8) else { throw NullError.Null }
                output.append(jsonString)
                output.append("\n******************************\n")
            } catch NullError.Null {
                print("No results found. This means the Smartykey is likely not valid.")
            }
            catch {
            }
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
            do {
                let jsonData = try encoder.encode(result)
                guard let jsonString = String(data: jsonData, encoding: .utf8) else { throw NullError.Null }
                output.append(jsonString)
                output.append("\n******************************\n")
            } catch NullError.Null {
                print("No results found. This means the Smartykey is likely not valid.")
            }
            catch {
            }
        }
        
        output.append("\n******************************\n")

        return output
    }
    
    enum NullError: Error {
        case Null
    }
}
