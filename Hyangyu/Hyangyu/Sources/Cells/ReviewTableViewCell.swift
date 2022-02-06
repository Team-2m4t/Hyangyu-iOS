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
       setStyle()
    }
    func setStyle() {
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
    }
    func setData(title: String, review: String, data: String, scope: Double) {
        scopeLabel.text = String(scope)
        reviewLabel.text = review
        titleLabel.text = title
        dataLabel.text = data
    }
}
