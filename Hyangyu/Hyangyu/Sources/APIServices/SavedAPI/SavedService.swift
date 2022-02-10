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
    
    case saveMyDisplay(displayId: Int)
    
    case deleteMySavedDisplay(displayId: Int)
    
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
        case .saveMyDisplay(let displayID):
            return Const.URL.displayURL + "/\(displayID)"
        case .deleteMySavedDisplay(let displayID):
            return Const.URL.displayURL + "/\(displayID)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMyDisplay:
            return .get
        case .saveMyDisplay:
            return .post
        case .deleteMySavedDisplay:
            return .delete
            
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    
    var task: Task {
        switch self {
        case .getMyDisplay, .saveMyDisplay, .deleteMySavedDisplay:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        
        switch self {
        case .getMyDisplay, .saveMyDisplay, .deleteMySavedDisplay:
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "jwtToken") ?? "")"
            ]
        }
    }
}

