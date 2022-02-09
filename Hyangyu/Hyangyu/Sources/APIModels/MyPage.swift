//
//  MyPage.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/02/07.
//

import Foundation

// MARK: - message
struct ModifyCheckData: Codable {
    let message: String
}

// MARK: - MyPage
struct MyPageResponse: Codable {
    let image: String?
    let username: String
    var displays: [Event]
}

// MARK: - SavedResponse
struct SavedResponse: Codable {
    var displays: [Event]
}

// MARK: - Display, Fair, Festival
struct Event: Codable {
    let eventID: Int
    let title: String
    let startDate, endDate: String
    let weekdayClose, weekendOpen, weekendClose, weekdayOpen: String
    let location: String
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
