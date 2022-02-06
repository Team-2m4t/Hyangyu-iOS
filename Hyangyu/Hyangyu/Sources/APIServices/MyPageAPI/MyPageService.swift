//
//  MyPageService.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/02/07.
//

import Foundation
import Moya

enum MyPageService {
    
    case modifyUserName(email:String, password:String, nickname: String)

}

extension MyPageService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    var path: String {
        switch self {
        case .modifyUserName(_, _, _):
            return Const.URL.modifyUserName


        }
    }
    
    var method: Moya.Method {
        switch self {
        case .modifyUserName(_, _, _):
            return .post

        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .modifyUserName(let email, let password, let nickname):
            return .requestParameters(parameters: [
                "email": nil,
                "password": nil,
                "username": nickname,
            ], encoding: JSONEncoding.default)
          
        }
    }
    
    var headers: [String: String]? {

        switch self {
        case .modifyUserName(_, _, _):
            return [
                "Content-Type": "application/json",
                "Bearer": UserDefaults.standard.string(forKey: "jwtToken") ?? ""
            ]
        }
    }
}
