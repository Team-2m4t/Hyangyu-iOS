//
//  InnerCollectionViewScrollDelegate.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/20.
//

import Foundation
import UIKit
protocol InnerCollectionViewScrollDelegate: AnyObject {
    var currentHeaderHeight: CGFloat { get }
    func innerCollectionViewDidScroll(withDistance scrollDistance: CGFloat)
    func innerCollectionViewScrollEnded(withScrollDirection scrollDirection: DragDirection)
}
