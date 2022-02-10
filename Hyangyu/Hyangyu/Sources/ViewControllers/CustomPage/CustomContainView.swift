//
//  CustomContainView.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/20.
//

import UIKit


public
typealias CustomController = (UIViewController & CustomChildViewController)

class CustomContainView: UIView {
    weak var viewController: CustomController?
    var isEmpty: Bool {
        return subviews.isEmpty
    }
    
    func displaying(in view: UIView, containView: UIView) -> Bool {
        let convertedFrame = containView.convert(frame, to: view)
        return view.frame.intersects(convertedFrame)
    }
}

