//
//  HashtagCollectionViewCell.swift
//  Hyangyu
//
//  Created by 길태연 on 2022/01/18.
//

import UIKit

class HashtagCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "HashtagCollectionViewCell"

    
    
    @IBOutlet weak var hashtagImageView: UIImageView!
    
    func setData(imageName: String){
        if let image = UIImage(named: imageName){
            hashtagImageView.image = image
        }
        
    }
    
}
