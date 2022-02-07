//
//  ReviewCollectionViewCell.swift
//  Hyangyu
//
//  Created by 홍희수 on 2022/02/07.
//

import UIKit

class ReviewCollectionViewCell: UICollectionViewCell {
    
    static let identifier : String = "ReviewCollectionViewCell"
    
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var createTime: UILabel!
    @IBOutlet weak var reviewContent: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(nickName: String, createtime: String, reviewcontent: String){
        nickname.text = nickName
        createTime.text = createtime
        reviewContent.text = reviewcontent
    }
    @IBAction func reportButtonClicked(_ sender: Any) {
    }
    
}
