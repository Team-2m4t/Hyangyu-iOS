//
//  Page.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/20.
//

import Foundation
import UIKit

struct Page {
    var name: String
    var contentViewController: UIViewController

    init(name: String, contentViewController: UIViewController) {
        self.name = name
        self.contentViewController = contentViewController
    }
}

struct PageCollection {
    var selectedPageIndex = 0
    var pages = [Page]()
}
