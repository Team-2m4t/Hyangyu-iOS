//
//  SearchService.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/02/10.
//

import Foundation

import Moya

enum SearchService {
    
    case search(keyword: String)
    
}

extension SearchService: TargetType, AccessTokenAuthorizable {
    var authorizationType: AuthorizationType? {
        return .bearer
    }
    
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    var path: String {
        switch self {
        case .search(let keyword):
            return Const.URL.searchURL + "/\(keyword)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .search:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    
    var task: Task {
        switch self {
        case .search(let keyword):
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        
        switch self {
        case .search:
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "jwtToken") ?? "")"
            ]
        }
    }
}
