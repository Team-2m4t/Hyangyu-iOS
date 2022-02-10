//
//  ServiceDataModel.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/02/06.
//

import Foundation
import UIKit

struct ServiceDataModel {
    var title: String
    var placeTitle: String
    var dateTitle: String
    var iconImageName: String
    
    init(iconImageName: String, title: String, placeTitle: String, dateTitle: String){
        self.iconImageName = iconImageName
        self.title = title
        self.placeTitle = placeTitle
        self.dateTitle = dateTitle
    }
}
