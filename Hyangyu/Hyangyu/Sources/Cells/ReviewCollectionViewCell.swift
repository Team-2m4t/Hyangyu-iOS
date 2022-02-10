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
    var reviewNumber: Int!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(displayReview: ReviewDisplayResponse){
        nickname.text = displayReview.username
        createTime.text = displayReview.createTime
        reviewContent.text = displayReview.content
        reviewNumber = displayReview.reviewID
    }
    @IBAction func reportButtonClicked(_ sender: Any) {
        //리뷰 신고
    }
    
}
