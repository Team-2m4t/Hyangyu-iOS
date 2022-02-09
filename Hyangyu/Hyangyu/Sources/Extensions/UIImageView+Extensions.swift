//
//  UIImageView+Extensions.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/02/08.
//

import Foundation
import Kingfisher

extension UIImageView {
    
    @discardableResult
    func updateServerImage(_ imagePath: String) -> Bool {
        guard let url = URL(string: imagePath) else {
            return false
        }
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: UIImage(),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0)),
                .cacheOriginalImage
            ]) { result in
            switch result {
            case .success:
                return
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        return true
    }
}
