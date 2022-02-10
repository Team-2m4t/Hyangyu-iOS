//
//  ReviewCollectionViewCell.swift
//  Hyangyu
//
//  Created by 홍희수 on 2022/02/07.
//
import Foundation
import UIKit

class ReviewCollectionViewCell: UICollectionViewCell {
    //let dateFormatter = DateFormatter()
    
    static let identifier : String = "ReviewCollectionViewCell"
    
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var createTime: UILabel!
    @IBOutlet weak var reviewContent: UILabel!
    var reviewNumber: Int!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /*func setData(displayReview: ReviewDisplayResponse){
        nickname.text = displayReview.username
        createTime.text = displayReview.createTime
        reviewContent.text = displayReview.content
    }*/
    
    func setData(nickName: String, createtime: String, reviewcontent: String){
        nickname.text = nickName
        createTime.text = createtime
        reviewContent.text = reviewcontent
    }
    
    @IBAction func reportButtonClicked(_ sender: Any) {
    }
    
}
