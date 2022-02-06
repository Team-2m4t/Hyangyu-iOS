//
//  CategoryCollectionViewCell.swift
//  Hyangyu
//
//  Created by 홍희수 on 2022/01/19.
//

import UIKit

// protocol 만들기 -> CollectionViewCell이랑 index 반환
protocol CollectionViewCellDelegate: AnyObject {
    func collectionView(collectionviewcell: CategoryCollectionViewCell?, index: Int)
}

class CategoryCollectionViewCell: UICollectionViewCell {
    
    weak var cellDelegate: CollectionViewCellDelegate?
    
    static let identifier: String = "CategoryCollectionViewCell"
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(iconName: String, title: String, placeTitle: String, dateTitle: String) {
        titleLabel.text = title
        placeLabel.text = placeTitle
        dateLabel.text = dateTitle
        
        if let icon = UIImage(named: iconName) {
            posterImageView.image = icon
        }
    }

}
