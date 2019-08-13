import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "lines-map")?.draw(in: self.view.bounds)
        let background = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: background!)
    }

    @IBAction func swift(_ sender: Any) {
        performSegue(withIdentifier: "swiftController", sender: self)
    }
    
    @IBAction func objc(_ sender: Any) {
        performSegue(withIdentifier: "objcController", sender: self)
    }
}

