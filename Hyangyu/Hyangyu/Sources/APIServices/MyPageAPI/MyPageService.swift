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
    
    case getUserData
    
}

extension MyPageService: TargetType, AccessTokenAuthorizable {
    var authorizationType: AuthorizationType? {
        return .bearer
    }
    
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    var path: String {
        switch self {
        case .modifyUserName(_, _, _):
            return Const.URL.modifyUserNameURL
        case .getUserData:
            return Const.URL.myPageURL
            
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .modifyUserName(_, _, _):
            return .post
        case .getUserData:
            return .get
            
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
        case .getUserData:
            return .requestPlain
            
        }
    }
    
    var headers: [String: String]? {
        
        switch self {
        case .modifyUserName(_, _, _), .getUserData:
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "jwtToken") ?? "")"
            ]
        }
    }
}
