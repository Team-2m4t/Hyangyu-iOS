//
//  CategoryLatest.swift
//  Hyangyu
//
//  Created by 홍희수 on 2022/02/09.
//

import Foundation
// MARK: - DataClass
struct CagetoryDisplayResponse: Codable {
    var displays: [Event]
}

// MARK: - Display
struct Event: Codable {
    let eventID: Int
    let title, startDate, endDate, weekdayOpen: String
    let weekdayClose, weekendOpen, weekendClose, location: String
    let site, holiday, content: String
    let photo1: String
    let photo2, photo3: String?
    let price: Int
    let saved: Bool

    enum CodingKeys: String, CodingKey {
        case eventID = "eventId"
        case title, startDate, endDate, weekdayOpen, weekdayClose, weekendOpen, weekendClose, location, site, holiday, content, photo1, photo2, photo3, price, saved
    }
}
