//
//  ReviewDisplayResponse.swift
//  Hyangyu
//
//  Created by 홍희수 on 2022/02/10.
//

import Foundation

// MARK: - Datum
// MARK: - Datum
struct ReviewDisplayResponse: Codable {
    let photo: JSONNull?
    let username, createTime, content: String
    let score, reviewID: Int

    enum CodingKeys: String, CodingKey {
        case photo, username, createTime, content, score
        case reviewID = "reviewId"
    }
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
