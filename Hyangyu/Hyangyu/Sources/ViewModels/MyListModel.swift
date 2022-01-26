//
//  MyListModel.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/22.
//

import Foundation
import UIKit

struct MyListModel {
    let posterImageURL: String?
    let title: String
    let startDate: String
    let endDate: String
    let location: String
    
    init(posterImageURL: String,
         title: String,
         startDate: String,
         endDate: String,
         location: String) {
        self.posterImageURL = posterImageURL
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.location = location
    }
}
