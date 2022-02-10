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
    
    // 토스트 메세지
    func showToast(message: String) {
        // 토스트 위치
        let toastLabel = UILabel(frame: CGRect(x: 30,
                                               y: self.view.frame.size.height - 95,
                                               width: self.view.frame.size.width - 60,
                                               height: 40))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.text = message
        toastLabel.textAlignment = .center
        toastLabel.layer.cornerRadius = 12
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 1.0, delay: 0.5,
                       options: .curveEaseIn, animations: { toastLabel.alpha = 0.0 },
                       completion: {_ in toastLabel.removeFromSuperview() })
    }
}
