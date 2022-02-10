//
//  Search.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/02/10.
//

import Foundation

struct SearchResultResponse: Codable {
    var display: [Event]
    var fair: [Event]
    var festival: [Event]
}
