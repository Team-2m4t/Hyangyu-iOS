//
//  PasswordService.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/02/03.
//

import Foundation
import Moya

enum PasswordService {
    case putChangedPassword(email: String, password: String)
    case postEmailCode(email: String)
    
}

extension PasswordService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .putChangedPassword(_, _):
            return Const.URL.passwordURL
        case .postEmailCode(let email):
            return Const.URL.findPasswordURL + "/\(email)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .putChangedPassword(_, _):
            return .put
        case .postEmailCode(_):
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .putChangedPassword(let email, let password):
            // body가 있는 request - JSONEncoding.default
            return .requestParameters(parameters: [
                "email": email,
                "password": password
            ], encoding: JSONEncoding.default)
        case .postEmailCode(_):
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
}
