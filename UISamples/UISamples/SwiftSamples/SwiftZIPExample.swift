import UIKit
import sdk

class SwiftZIPExample: UIViewController, UITextFieldDelegate {

    var batch:USZipCodeBatch = USZipCodeBatch()
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
    
    @IBAction func add(_ sender: Any) {
        var error:NSError? = nil
        
        //        Documentation for input fields can be found at:
        //        https://smartystreets.com/docs/us-zipcode-api#input-fields
        let lookup = USZipCodeLookup(city: city.text!, state: state.text, zipcode: zipCode.text, inputId: inputId.text)
        let pointer = UnsafeMutablePointer<USZipCodeLookup>.allocate(capacity: 1)
        pointer.initialize(to: lookup)
        _ = self.batch.add(newAddress: pointer, error: &error)
        if let error = error {
            let output = """
            Domain: \(error.domain)
            Code: \(error.code)
            Description: \(error.userInfo[NSLocalizedDescriptionKey] ?? "")
            """
            NSLog(output)
            results.text = output
        }
    }
    
    @IBAction func lookUp(_ sender: Any) {
        self.results.text = run()
        self.batch = USZipCodeBatch()
    }
    
    func run() -> String {
        let authId = "af79ba24-4971-9d11-ec86-e0c768a7694e"
        let authToken = "DGQcdrLC2TmOm913YUe7"
        let client = ClientBuilder(authId: authId, authToken: authToken).buildUsZIPCodeApiClient()
        var error:NSError? = nil
        
        _ = client.sendBatch(batch: batch, error: &error)
        
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
        
        let lookups = batch.allLookups as! [USZipCodeLookup]
        
        for lookup in lookups {
            output.append("\nInput ID: \(lookup.inputId ?? "")")
            if let cities = lookup.result.cities, let zipCodes = lookup.result.zipCodes {
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
        }
        return output
    }
    
    
    @IBAction func Return(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
