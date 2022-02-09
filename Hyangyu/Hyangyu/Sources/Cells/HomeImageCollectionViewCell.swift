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
        let url = URL(string: "https://image.tmdb.org/t/p/original\(imageName)")
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.posterImageView.image = UIImage(data: data!)
            }
        }
                           
    }
    func setImage() {
        posterImageView.layer.cornerRadius = 70
        posterImageView.layer.masksToBounds = true
        posterImageView.layer.maskedCorners = [.layerMinXMaxYCorner]
    }
}
