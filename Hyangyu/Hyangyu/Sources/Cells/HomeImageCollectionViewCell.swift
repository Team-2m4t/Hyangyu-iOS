//
//  HomeImageCollectionViewCell.swift
//  Hyangyu
//
//  Created by 길태연 on 2022/01/18.
//

import UIKit

class HomeImageCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "HomeImageCollectionViewCell"
    @IBOutlet weak var posterImageView: UIImageView!
    func setData(imageName: String) {
        if let image = UIImage(named: imageName) {
            posterImageView.image = image
        }
        
    }
    
}
