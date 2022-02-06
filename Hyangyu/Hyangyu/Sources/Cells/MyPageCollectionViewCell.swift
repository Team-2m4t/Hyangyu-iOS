//
//  MyPageCollectionViewCell.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/20.
//

import UIKit

class MyPageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var startDateLabel: UILabel!
    
    @IBOutlet weak var endDateLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Functions
    
    // set Data functions
    
    public func setData(myList: MyListModel){
        posterImageView.image = UIImage(named: myList.posterImageURL ?? "exhibitionImg1")
        titleLabel.text = myList.title
        startDateLabel.text = myList.startDate
        endDateLabel.text = myList.endDate
        locationLabel.text = myList.location
    }
    
}
