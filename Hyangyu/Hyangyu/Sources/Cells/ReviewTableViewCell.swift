import UIKit

protocol ContentsMainTextDelegate: AnyObject {
    func optionButtonTapped()
    
}

class ReviewTableViewCell: UITableViewCell {
    
    static let identifier: String = "ReviewTableViewCell"

    @IBOutlet weak var scopeLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var optionButton: UIButton!
    var actionClosure: (() -> Void)? = nil
    var reviewList: [ReviewDataModel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        whiteView.layer.shadowColor = UIColor.black.cgColor
        whiteView.layer.shadowOffset = CGSize(width: 5, height: 5)
        whiteView.layer.shadowOpacity = 0.2
        whiteView.layer.shadowRadius = 7
        whiteView.layer.cornerRadius = 3
    }
    
    @IBAction func optionButton(_ sender: Any) {
        self.actionClosure?()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

 //       self.optionButton.addTarget(self, action: #selector(<#T##@objc method#>), for: <#T##UIControl.Event#>)
    }
    
    func setData(title: String, review: String, data: String, scope: Double) {
        scopeLabel.text = String(scope)
        reviewLabel.text = review
        titleLabel.text = title
        dataLabel.text = data
    }
  
//    class MainTextCell : UITableViewCell {
//        
//        var cellDelegate : ContentsMainTextDelegate?
//        opt
//    }
//    
//    

}
extension ReviewTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath)
            as? ReviewTableViewCell;
        
        cell?.actionClosure = {
            [weak self] in let option = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let deleteAction = UIAlertAction(title: "리뷰 삭제", style: .default)
                {(action) in
                        let alert = UIAlertController(title: "리뷰 삭제", message: "리뷰를 삭제하시겠어요?", preferredStyle: UIAlertController.Style.alert)
                        let okAction = UIAlertAction(title: "취소", style: .default) {(action) in }
                        let removeAction = UIAlertAction(title: "삭제하기", style: .default) {(action) in
            
                        }
            
//                        okAction.setValue(self.green, forKey:"titleTextColor")
//
//                        removeAction.setValue(self.green, forKey:"titleTextColor")
                        alert.addAction(okAction)
                        alert.addAction(removeAction)
                        self?.setSelected(true, animated: true)
                        }
            
//                    let editAction = UIAlertAction(title: "리뷰 수정", style: .default) {
//                        (action) in
//                        guard let reviewEdit = self.storyboard?.instantiateViewController(identifier: "ReviewEditViewController") as? ReviewEditViewController else {return }
//                        self.present(reviewEdit,animated: true,completion: nil)
//                        reviewEdit.modalPresentationStyle = .fullScreen
//
//                    }
//                    let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: {(alert: UIAlertAction!) -> Void in })
//                    cancelAction.setValue(green, forKey:  "titleTextColor")
//                    deleteAction.setValue(UIColor.black, forKey: "titleTextColor")
//                    editAction.setValue(UIColor.black, forKey: "titleTextColor")
//                    option.addAction(deleteAction)
//                    option.addAction(editAction)
//                    option.addAction(cancelAction)
            
            //        self.present(option, animated: true, completion: nil)
        }
        return cell!
}
}
