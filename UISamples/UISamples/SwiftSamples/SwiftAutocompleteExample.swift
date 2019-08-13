import UIKit
import sdk

class SwiftAutocompleteExample: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var cityFilter: UITextField!
    @IBOutlet weak var stateFilter: UITextField!
    @IBOutlet weak var prefer: UITextField!
    @IBOutlet weak var prefix: UITextField!
    @IBOutlet weak var result: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "lines-map")?.draw(in: self.view.bounds)
        let background = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: background!)
        
        prefix.delegate = self
        cityFilter.delegate = self
        stateFilter.delegate = self
        prefer.delegate = self
    }
    
    @IBAction func addressChanged(_ sender: Any) {
        result.text = run()
    }
    
    func run() -> String {
        let client = ClientBuilder(id: "key", hostname: "hostname").buildUSAutocompleteApiClient()
        
        if let prefix = self.prefix.text {
            //            Documentation for input fields can be found at:
            //            https://smartystreets.com/docs/us-autocomplete-api#http-request-input-fields
            
            var lookup = USAutocompleteLookup().withPrefix(prefix: prefix)
            var error:NSError? = nil
            
            if let cityFilter = self.cityFilter.text {
                lookup.addCityFilter(city: cityFilter)
            }
            
            if let stateFilter = self.stateFilter.text {
                lookup.addStateFilter(state: stateFilter)
            }
            
            if let prefer = self.prefer.text {
                lookup.addPrefer(cityORstate: prefer)
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
                    output.append("\(suggestion.text ?? "")\n")
                }
            }
            return output
        }
        return "Uncaught Error"
    }
    
    @IBAction func Return(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
