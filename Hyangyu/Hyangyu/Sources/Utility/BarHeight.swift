//
//  BarHeight.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/20.
//

import UIKit

protocol BarHeight where Self: UIViewController {
    func statusBarHeight() -> CGFloat
    func navigationBarHeight() -> CGFloat
}

extension BarHeight {
    func statusBarHeight() -> CGFloat {
        self.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? .zero
    }

    func navigationBarHeight() -> CGFloat {
        self.navigationController?.navigationBar.frame.height ?? .zero
    }
}

