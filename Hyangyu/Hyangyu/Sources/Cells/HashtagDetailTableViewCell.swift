//
//  HashtagDetailTableViewCell.swift
//  Hyangyu
//
//  Created by 길태연 on 2022/01/19.
//

import UIKit

class HashtagDetailTableViewCell: UITableViewCell {

    static let identifier : String = "HashtagDetailTableViewCell"
    @IBOutlet var hashDetailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var circleView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        circleView.layer.cornerRadius = 4 
        // Initialization code
    }
    
    
    func setData(imageName: String,title : String, subtitle: String,data : String){
        if let image = UIImage(named: imageName){
            hashDetailImageView.image = image
        }
        titleLabel.text = title
        placeLabel.text = subtitle
        dataLabel.text = data
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
