//
//  LoginService.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/26.
//

import Foundation
import Moya

enum LoginService {
    
    case postSignIn(email: String, password: String)
    
}

extension LoginService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .postSignIn:
            return Const.URL.signInURL
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postSignIn :
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .postSignIn(let email, let password):
            return .requestParameters(parameters: [
                "email": email,
                "password": password
            ], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return [
            "Conten-Type": "application/json",
        ]
    }
}
