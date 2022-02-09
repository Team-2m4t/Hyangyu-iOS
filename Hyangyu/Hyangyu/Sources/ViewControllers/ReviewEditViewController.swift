//
//  ReviewEditViewController.swift
//  Hyangyu
//
//  Created by 길태연 on 2022/01/21.
//
import UIKit
protocol PassData {
    func passdata(data: String, num: Int)
}
class ReviewEditViewController: UIViewController {
    var reviewViewController: ReviewViewController?
    @IBOutlet weak var reviewField: UITextView!
    var reviewList: [ReviewModel] = []
    var review: String?
    var lalabel: String?
    var numberIndex: Int?
    var editText: String!
    var editMode: PassData!
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewField.becomeFirstResponder()
        reviewField.text = review
    }
    @IBAction func cancelButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func saveButton(_ sender: Any) {
        editText = reviewField.text
        editMode?.passdata(data: editText!, num: numberIndex! )
        navigationController?.popViewController(animated: true)
    }
}
