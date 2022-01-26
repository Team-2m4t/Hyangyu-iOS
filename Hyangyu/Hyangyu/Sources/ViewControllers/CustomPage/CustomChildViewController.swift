//
//  CustomChildViewController.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/20.
//

import Foundation
import UIKit

public protocol CustomChildViewController where Self: UIViewController {
    func customChildScrollView() -> UIScrollView
}
