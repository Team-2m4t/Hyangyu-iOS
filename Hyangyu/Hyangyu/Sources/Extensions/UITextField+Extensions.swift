//
//  UITextField+Extensions.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/21.
//

import Foundation
import UIKit

extension UITextField {
    func setUnderLine(color: UIColor?) {
        let border = UIView()
        border.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        border.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y + self.frame.height - 1, width: self.frame.width, height: 1)
        border.backgroundColor = color
        superview?.insertSubview(border, aboveSubview: self)
    }
}

extension UITextView {
    func setUnderLine(color: UIColor?) {
        let border = UIView()
        border.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        border.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y + self.frame.height - 1, width: self.frame.width, height: 1)
        border.backgroundColor = color
        superview?.insertSubview(border, aboveSubview: self)
    }
}
