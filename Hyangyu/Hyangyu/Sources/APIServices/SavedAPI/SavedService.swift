//
//  SavedService.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/02/08.
//

import Foundation

import Moya

enum SavedService {
    
    case getMyDisplay(page: Int)
    
}

extension SavedService: TargetType, AccessTokenAuthorizable {
    var authorizationType: AuthorizationType? {
        return .bearer
    }
    
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    var path: String {
        switch self {
        case .getMyDisplay(let page):
            return Const.URL.displayURL + "/\(page)"
            
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMyDisplay:
            return .get
            
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    
    var task: Task {
        switch self {
        case .getMyDisplay:
            return .requestPlain
            
        }
    }
    
    var headers: [String: String]? {
        
        switch self {
        case .getMyDisplay:
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "jwtToken") ?? "")"
            ]
        }
    }
}
