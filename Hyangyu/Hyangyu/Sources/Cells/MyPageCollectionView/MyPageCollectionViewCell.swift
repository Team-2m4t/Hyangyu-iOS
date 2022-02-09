//
//  MyPageCollectionViewCell.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/20.
//

import UIKit

final class MyPageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var startDateLabel: UILabel!
    
    @IBOutlet weak var endDateLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    let dateFormatter = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        // Initialization code
    }
    
    // MARK: - Functions
    
    // set Data functions
    
    public func setData(event: Event){
        if !posterImageView.updateServerImage(event.photo1) {
            posterImageView.image = UIImage(named: "exhibitionImg1")
        }
        titleLabel.text = event.title
        startDateLabel.text = event.startDate
        endDateLabel.text = event.endDate
        locationLabel.text = event.site
    }
    
}
