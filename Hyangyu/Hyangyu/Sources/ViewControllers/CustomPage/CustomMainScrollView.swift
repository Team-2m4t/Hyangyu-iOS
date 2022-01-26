//
//  CustomMainScrollView.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/20.
//

import UIKit

public class CustomMainScrollView: UIScrollView, UIGestureRecognizerDelegate {
    var headerViewHeight: CGFloat = 0.0
    var menuViewHeight: CGFloat = 0.0
    var statusBarHeight: CGFloat = 0.0
    
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        scrollsToTop = true
        backgroundColor = .white
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        guard let scrollView = gestureRecognizer.view as? UIScrollView else {
            return false
        }
        
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        
        
        let offsetY = headerViewHeight + menuViewHeight
        let contentSize = scrollView.contentSize
        let targetRect = CGRect(x: 0,
                                y: offsetY - statusBarHeight,
                                width: contentSize.width,
                                height: contentSize.height - offsetY)
        
        let currentPoint = gestureRecognizer.location(in: self)
        return targetRect.contains(currentPoint)
    }
}
