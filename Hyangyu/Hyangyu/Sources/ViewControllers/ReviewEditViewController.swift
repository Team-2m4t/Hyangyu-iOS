//
//  ReviewEditViewController.swift
//  Hyangyu
//
//  Created by 길태연 on 2022/01/21.
//

import UIKit

class ReviewEditViewController: UIViewController {
    var reviewViewController: ReviewViewController?
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var reviewField: UITextField!
    var reviewList: [ReviewDataModel] = []
    var review: String?
    var lalabel: String?
    var numberIndex: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
    //    setdata()
    // reviewField.text = "add"
        label.text = lalabel
        reviewField.text = review

        // Do any additional setup after loading the view.
    }
    
//    func setdata(){
//        if let review = self.review, let lalabel = self.lalabel {
//            print("fkfkfk")
//            reviewField.text = review
//            label.text = lalabel
//            
//            
//        }
//    }

    @IBAction func cancelButton(_ sender: Any) {
    }
    
    @IBAction func saveButton(_ sender: Any) {
    //    print(count!)
    // reviewList[count!].review == reviewField.text!
        
       // self.performSegue(withIdentifier: "showDetail", sender: count!)
     
        reviewViewController?.review = reviewField.text!
    
        reviewViewController?.hello() 
        self.dismiss(animated: true, completion: nil)
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showDetail" {
//           if let destination = segue.destination as? ReviewViewController {
//            destination.review = reviewField.text!
//            }
//        }
//    }
//
    override func viewWillDisappear(_ animated: Bool) {
        
  //      if let context = (UIApplication.shared.delegate as? AppDelegate)
  //      print(reviewViewController?.review )
       //    reviewViewController?.review = reviewField.text!
      //  reviewViewController?.count = numberIndex
    // reviewList.remove(at: count!)
      //  reviewList[numberIndex!].review = reviewField.text!
     //   print(reviewField.text!)
     //   print(reviewList[0].review)
  //      reviewList[count!].review = reviewField.text!
        
    //    reviewViewController?.reviewTableView.reloadData();
    }
}
