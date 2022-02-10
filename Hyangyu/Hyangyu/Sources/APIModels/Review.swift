//
//  Review.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/02/10.
//

import Foundation

struct ReviewRequest {
    var content: String
    var score: Int
}

struct ReviewResponse: Codable {
    let reviewId: Int
}
