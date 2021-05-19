import UIKit
import SmartyStreets

class SwiftUSStreetExample: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var freeform: UITextField!
    @IBOutlet weak var street: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var results: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "lines-map")?.draw(in: self.view.bounds)
        let background = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: background!)
        
        street.delegate = self
        city.delegate = self
        state.delegate = self
        freeform.delegate = self
    }
    
    @IBAction func lookup(_ sender: Any) {
        results.text = run()
        self.view.endEditing(true)
    }
    
    func run() -> String{
        // The appropriate license values to be used for your subscriptions can be found on the Subscriptions page of the account dashboard.
        // https://www.smartystreets.com/docs/cloud/licensing
        let client = ClientBuilder(id: "KEY", hostname: "hostname").withLicenses(["us-rooftop-geocoding-cloud"])
            .buildUsStreetApiClient()
        var lookup = USStreetLookup()
        
        // Documentation for input fields can be found at:
        // https://smartystreets.com/docs/cloud/us-street-api
        
        if freeform.text != "" {
            if let freeform = freeform.text {
                lookup = USStreetLookup(freeformAddress: freeform)
            }
        } else {
            lookup.street = street.text
            lookup.city = city.text
            lookup.state = state.text
        }
        var error:NSError! = nil
        
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
        
        var output = "Results: \n"
        
        if lookup.result == nil {
            return "\nAddress is invalid\n"
        }
        
        let candidates:[USStreetCandidate] = lookup.result
        
        for candidate in candidates {
            output.append("""
                Address is valid. (There is at least one candidate)\n\n
                \nZIP Code: \(candidate.components?.zipCode ?? "")
                \nCounty: \(candidate.metadata?.countyName ?? "")
                \nLatitude: \(candidate.metadata?.latitude ?? 0.0)
                \nLongitude: \(candidate.metadata?.longitude ?? 0.0)
                """)
        }
        
        output.append("\n******************************\n")

        return output
    }
    
    @IBAction func Return(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
