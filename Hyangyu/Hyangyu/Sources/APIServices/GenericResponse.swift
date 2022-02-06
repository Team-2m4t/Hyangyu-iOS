//
//  GenericResponse.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/26.
//

import Foundation

struct GenericResponse<T: Codable>: Codable {
    var status: Int
    var message: String?
    var data: T?
    
    enum CodingKeys: String, CodingKey {
        case message
        case data
        case status
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode(T.self, forKey: .data)) ?? nil
        status = (try? values.decode(Int.self, forKey: .status)) ?? 0
    }
}
