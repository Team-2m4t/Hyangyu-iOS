//
//  ReviewService.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/02/10.
//

import Foundation

import Moya

enum ReviewService {
    
    case postDisplayReview(displayId: Int, content: String, score: Int)
    
}

extension ReviewService: TargetType, AccessTokenAuthorizable {
    var authorizationType: AuthorizationType? {
        return .bearer
    }
    
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    var path: String {
        switch self {
        case .postDisplayReview(let displayId):
            return Const.URL.displayReviewURL + "/\(displayId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postDisplayReview:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    
    var task: Task {
        switch self {
        case .postDisplayReview(let displayId, let content, let score):
            return .requestParameters(parameters: [
                "content": content,
                "score": score,
            ], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        
        switch self {
        case .postDisplayReview:
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "jwtToken") ?? "")"
            ]
        }
    }
}
