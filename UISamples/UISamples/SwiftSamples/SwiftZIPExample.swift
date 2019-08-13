import UIKit
import sdk

class SwiftZIPExample: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    @IBOutlet weak var inputId: UITextField!
    @IBOutlet weak var results: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "lines-map")?.draw(in: self.view.bounds)
        let background = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: background!)
        
        city.delegate = self
        state.delegate = self
        zipCode.delegate = self
        inputId.delegate = self
    }
    
    @IBAction func lookUp(_ sender: Any) {
        self.results.text = run()
        self.view.endEditing(true)
    }
    
    func run() -> String {
        let client = ClientBuilder(id: "key", hostname: "hostname").buildUsZIPCodeApiClient()
        
        var error:NSError? = nil
        
        // Documentation for input fields can be found at:
        // https://smartystreets.com/docs/cloud/us-zipcode-api
        
        let lookup = USZipCodeLookup(city: city.text!, state: state.text, zipcode: zipCode.text, inputId: inputId.text)
        let pointer = UnsafeMutablePointer<USZipCodeLookup>.allocate(capacity: 1)
        pointer.initialize(to: lookup)
        
        _ = client.sendLookup(lookup: pointer, error: &error)
        
        var output:String = String()
        
        if let error = error {
            output = """
            Domain: \(error.domain)
            Code: \(error.code)
            Description: \(error.userInfo[NSLocalizedDescriptionKey] ?? "")
            """
            NSLog(output)
            return output
        }
        
        let result = lookup.result as USZipCodeResult
        
        if let cities = result.cities, let zipCodes = result.zipCodes {
            for city in cities {
                output.append("""
                    \nCity: \(city.city ?? "")
                    State: \(city.state ?? "")
                    Mailable City: \(city.mailablecity ?? true)\n
                    """)
            }
            
            for zip in zipCodes {
                output.append("""
                    \nZIP Code: \(zip.zipCode ?? "")
                    Latitude: \(zip.latitude ?? 0)
                    Longitude: \(zip.longitude ?? 0)\n
                    """)
            }
        }
        return output
    }
    
    
    @IBAction func Return(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
