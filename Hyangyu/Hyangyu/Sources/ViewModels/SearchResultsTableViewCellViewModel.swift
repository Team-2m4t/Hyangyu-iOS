//
//  SearchResultsTableViewCellViewModel.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/24.
//

import Foundation

struct SearchResultsTableViewCellViewModel {
    let eventID: Int
    let title, startDate, endDate, weekdayOpen: String
    let weekdayClose, weekendOpen, weekendClose, location: String
    let site, holiday, content: String
    let photo1: String
    let photo2, photo3: String?
    let price: Int
    let saved: Bool
}
