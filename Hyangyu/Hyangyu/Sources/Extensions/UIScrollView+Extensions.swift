//
//  UIScrollView+Extensions.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/20.
//

import Foundation
import UIKit


private struct AssociatedKeys {
    static var AMIsCanScroll = "AMIsCanScroll"
    static var AMOriginOffset = "AMOriginOffset"
}

extension UIScrollView {
    internal var am_isCanScroll: Bool {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.AMIsCanScroll) as? Bool) ?? false
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.AMIsCanScroll, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    internal var am_originOffset: CGPoint? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.AMOriginOffset) as? CGPoint
        }
        set {
            guard am_originOffset == nil else {
                return
            }
            objc_setAssociatedObject(self, &AssociatedKeys.AMOriginOffset, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}



extension Optional where Wrapped == CGPoint{
    var val: CGPoint{
        if let v = self{
            return v
        }
        else{
            return .zero
        }
    }
}


extension Optional where Wrapped == UIScrollView{
    var offset: CGPoint{
        if let v = self?.am_originOffset.val{
            return v
        }
        else{
            return .zero
        }
    }
}






extension UIView{
    
    
    func addSubs(_ views: [UIView]){
        views.forEach(addSubview(_:))
    }
 
    
    
}

