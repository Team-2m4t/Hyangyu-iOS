//
//  PersonDataModel.swift
//  Hyangyu
//
//  Created by 길태연 on 2022/02/07.
//
//
//import Foundation
//
//// This file was generated from JSON Schema using quicktype, do not modify it directly.
//// To parse the JSON, add this file to your project and do:
////
////   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)
//
//// MARK: - Welcome
//struct ReviewAPIDataModel: Codable {
//    let id, page: Int
//    let results: [Review]
//    let totalPages, totalResults: Int
//
//    enum CodingKeys: String, CodingKey {
//        case id, page, results
//        case totalPages = "total_pages"
//        case totalResults = "total_results"
//    }
//}
//// MARK: - Result
//struct Review: Codable {
//    let author: String
//    let authorDetails: AuthorDetails
//    let content, createdAt, id, updatedAt: String
//    let url: String
//
//    enum CodingKeys: String, CodingKey {
//        case author
//        case authorDetails = "author_details"
//        case content
//        case createdAt = "created_at"
//        case id
//        case updatedAt = "updated_at"
//        case url
//    }
//}
//
//// MARK: - AuthorDetails
//struct AuthorDetails: Codable {
//    let name, username: String
//    let avatarPath: String?
//    let rating: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case name, username
//        case avatarPath = "avatar_path"
//        case rating
//    }
//}


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct ReviewAPIDataModel: Codable {
    let status: Int
    let data: [Review]
}

// MARK: - Datum
struct Review: Codable {
    let photo: JSONNull?
    let username, createTime, content: String
    let score: Int
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
