import UIKit
import SmartyStreets

class SwiftUSEnrichmentExample: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var smartyKey: UITextField!
    @IBOutlet weak var lookupType: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "lines-map")?.draw(in: self.view.bounds)
        let background = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: background!)
        
        smartyKey.delegate = self
        lookupType.delegate = self
    }
    
    @IBAction func lookup(_ sender: Any) {
        results.text = run()
        self.view.endEditing(true)
    }
    
    func run() -> String{
        // The appropriate license values to be used for your subscriptions can be found on the Subscriptions page of the account dashboard.
        // https://www.smartystreets.com/docs/cloud/licensing
        let client = ClientBuilder(id: "KEY", hostname: "hostname")
            .buildUsEnrichmentApiClient()
        
        var error:NSError! = nil
        
        if lookupType.text.lowercased() == "principal" {
            var results = client.sendPropertyPrincipalLookup(smartyKey: smartyKey.text, error: error)
            return self.outputPrincipalResults(results)
        } else if lookup.text.lowercased() == "financial" {
            var results = client.sendPropertyFinancialLookup(smartyKey: smartyKey.text, error: error)
            return self.outputFinancialResults(results)
        }
    }
    
    @IBAction func Return(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
