//
//  Product.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/02/04.
//

import Foundation
import UIKit

struct Product: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case posterImageURL
        case title
        case startDate
        case finishedDate
        case location
    }
    

    // MARK: - Properties
    
    var posterImageURL: String
    var title: String
    var startDate: Date
    var finishedDate: Date
    var location: String
    
    private let dateFormatter = DateFormatter()

    // MARK: - Initializers

    func setup() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    init(posterImageURL: String, title: String, startDate: Date, finishedDate: Date, location: String) {
        self.posterImageURL = posterImageURL
        self.title = title
        self.startDate = startDate
        self.finishedDate = finishedDate
        self.location = location
        setup()
    }
    
    // MARK: - Formatters
    
    
    func formattedDate() -> String? {
        /** Build the date string.
            Use the yearFormatter to obtain the formatted year introduced.
        */
        return dateFormatter.string(from: startDate)
    }
    
    // MARK: - Codable
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(startDate, forKey: .startDate)
        try container.encode(finishedDate, forKey: .finishedDate)
        try container.encode(location, forKey: .location)
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        posterImageURL = try values.decode(String.self, forKey: .title)
        title = try values.decode(String.self, forKey: .title)
        startDate = try values.decode(Date.self, forKey: .startDate)
        finishedDate = try values.decode(Date.self, forKey: .finishedDate)
        location = try values.decode(String.self, forKey: .location)
        setup()
    }
    
}
