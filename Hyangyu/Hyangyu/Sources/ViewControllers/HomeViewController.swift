import UIKit

class HomeViewController: UIViewController {

  
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var exhibitionColor: UIButton!
    @IBOutlet weak var festivalColor: UIButton!
    @IBOutlet weak var fairColor: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        circleView.layer.cornerRadius = 4

        // Do any additional setup after loading the view.
    }
    
    @IBAction func exhibitionButton(_ sender: Any) {
        circleView.frame.origin.x = 20
        exhibitionColor.isHighlighted = false
        festivalColor.isHighlighted = true
        fairColor.isHighlighted = true
        
    }
    
    @IBAction func festivalButton(_ sender: Any) {
        circleView.frame.origin.x = 102
        exhibitionColor.isHighlighted = true
        festivalColor.isHighlighted = false
        fairColor.isHighlighted = true
    }
    
    @IBAction func fairButton(_ sender: Any) {
        circleView.frame.origin.x = 203
        exhibitionColor.isHighlighted = true
        festivalColor.isHighlighted = true
        fairColor.isHighlighted = false
    }
    
}
