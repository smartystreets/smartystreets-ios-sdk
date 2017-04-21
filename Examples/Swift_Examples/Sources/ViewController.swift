import UIKit
import SmartystreetsSDK

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var resultsTextView: UITextView!
    
    var pickerData: [String] = [String]()
    var pickerName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.picker.delegate = self
        self.picker.dataSource = self
        
        //Input data into the Array:
        self.pickerData = [
                        "USStreetSingleAddress",
                        "USStreetMultipleAddresses",
                        "USStreetLookupsWithMatchStrategy",
                        "USZipCodeSingleLookup",
                        "USZipCodeMultipleLookups",
                        "USAutocomplete",
                        "USExtract",
                        "InternationalStreet"]
        
        self.pickerName = pickerData[0]
        
        self.submitButton.addTarget(self, action: #selector(buttonClicked), for: UIControlEvents.touchUpInside)
    }
    
    func buttonClicked(_ sender:UIButton) {
        var result = ""
        
        if (pickerName == "USStreetSingleAddress") {
            let example = USStreetSingleAddressExample()
            result = example.run()
        }
        else if (pickerName == "USStreetMultipleAddresses") {
          let example = USStreetMultipleLookupsExample()
            result = example.run()
        }
        else if (pickerName == "USStreetLookupsWithMatchStrategy") {
            let example = USStreetLookupsWithMatchStrategyExamples()
            result = example.run()
        }
        else if (pickerName == "USZipCodeSingleLookup") {
            let example = USZipCodeSingleLookupExample()
            result = example.run()
        }
        else if (pickerName == "USZipCodeMultipleLookups") {
            let example = USZipCodeMultipleLookupsExample()
            result = example.run()
        }
        else if (pickerName == "USAutocomplete") {
            let example = USAutocompleteExample()
            result = example.run()
        }
        else if (pickerName == "USExtract") {
            let example = USExtractExample()
            result = example.run()
        }
        else if (pickerName == "InternationalStreet") {
            let example = InternationalStreetExample()
            result = example.run()
        }
        
        self.resultsTextView.text = result;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }

    // Catpure the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        self.pickerName = pickerData[row]
    }
}

