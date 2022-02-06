//
//  UIViewController+Extensions.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/20.
//

import Foundation
import UIKit

extension UIViewController {
    
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }
    
    public var amPageViewContoller: CustomPageViewController? {
        return parent as? CustomPageViewController
    }
    
    func clearFromParent() {
        willMove(toParent: nil)
        beginAppearanceTransition(false, animated: false)
        view.removeFromSuperview()
        endAppearanceTransition()
        removeFromParent()
    }
    
    func dismissKeyboardWhenTappedAround() {
            let tap: UITapGestureRecognizer =
                UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
            tap.cancelsTouchesInView = false
            self.view.addGestureRecognizer(tap)
        }
        
        @objc func dismissKeyboard() {
            self.view.endEditing(true)
        }
}
