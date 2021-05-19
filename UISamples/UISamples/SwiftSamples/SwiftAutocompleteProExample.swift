import UIKit
import SmartyStreets

class SwiftAutocompleteProExample: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var cityFilter: UITextField!
    @IBOutlet weak var stateFilter: UITextField!
    @IBOutlet weak var zipcodeFilter: UITextField!
    @IBOutlet weak var preferCity: UITextField!
    @IBOutlet weak var preferState: UITextField!
    @IBOutlet weak var preferZipcode: UITextField!
    @IBOutlet weak var search: UITextField!
    @IBOutlet weak var result: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "lines-map")?.draw(in: self.view.bounds)
        let background = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: background!)
        
        search.delegate = self
        cityFilter.delegate = self
        stateFilter.delegate = self
        preferCity.delegate = self
        preferState.delegate = self
    }
    
    @IBAction func addressChanged(_ sender: Any) {
        result.text = run()
    }
    
    func run() -> String {
        // The appropriate license values to be used for your subscriptions can be found on the Subscriptions page of the account dashboard.
        // https://www.smartystreets.com/docs/cloud/licensing
        let client = ClientBuilder(id: "Key", hostname: "Hostname").withLicenses(["us-autocomplete-pro-cloud"]).buildUSAutocompleteProApiClient()
        
        if let search = self.search.text {
            //            Documentation for input fields can be found at:
            //            https://smartystreets.com/docs/cloud/us-autocomplete-api#pro-http-response-status
            
            var lookup = USAutocompleteProLookup().withSearch(search: search)
            var error:NSError? = nil
            
            if let cityFilter = self.cityFilter.text {
                lookup.addCityFilter(city: cityFilter)
            }
            
            if let stateFilter = self.stateFilter.text {
                lookup.addStateFilter(state: stateFilter)
            }
            
            if let preferCity = self.preferCity.text {
                lookup.addPreferCity(city: preferCity)
            }
            
            if let preferState = self.preferState.text {
                lookup.addPreferState(state: preferState)
            }
            
            _ = client.sendLookup(lookup: &lookup, error: &error)
            if let error = error {
                let output = """
                Domain: \(error.domain)
                Error Code: \(error.code)
                Description:\n\(error.userInfo[NSLocalizedDescriptionKey] as! NSString)
                """
                NSLog(output)
                return output
            }
            
            var output = "Result: \n"
            
            if let result1 = lookup.result, let suggestions = result1.suggestions {
                for suggestion in suggestions {
                    output.append("\(buildAddress(suggestion: suggestion))\n")
                }
            }
            return output
        }
        return "Uncaught Error"
    }
    
    func buildAddress(suggestion: USAutocompleteProSuggestion) -> String {
        var whiteSpace = ""
        if let entries = suggestion.entries {
            if entries > 1 {
                whiteSpace.append(" (\(entries) entries)")
            }
        }
        return "\(suggestion.streetLine ?? "") \(suggestion.secondary ?? "") \(whiteSpace) \(suggestion.city ?? ""), \(suggestion.state ?? "") \(suggestion.zipcode ?? "")"
    }
    
    @IBAction func Return(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
