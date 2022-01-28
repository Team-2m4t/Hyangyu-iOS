//
//  UIImage+Extensions.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/21.
//
import UIKit

extension UIImage {
    
    func resize(newWidth: CGFloat) -> UIImage {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        let size = CGSize(width: newWidth, height: newHeight)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image {
            context in self.draw(in: CGRect(origin: .zero, size: size))
            
        }
        return renderImage
        
    }
}

