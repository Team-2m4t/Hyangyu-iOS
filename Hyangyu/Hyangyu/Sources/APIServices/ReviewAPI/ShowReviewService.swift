//
//  ShowReviewService.swift
//  Hyangyu
//
//  Created by 홍희수 on 2022/02/10.
//

import Foundation
import Moya

// 전시회 리뷰 조회 관련 서비스
enum ShowReviewService {
    
    case getDisplayReview(displayId: Int) // 리뷰 조회
}

extension ShowReviewService: TargetType, AccessTokenAuthorizable {
    var authorizationType: AuthorizationType? {
        return .bearer
    }
    // 우리 URL이 http://52.79.236.231:8080/api/display/1 이렇잖아.
   // 얘네느 baseURL + path로 경로 만들어
   // baseURL: http://52.79.236.231:8080/api
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
// path: Const.URL.myDisplayURL + "/\(page) => /display/:page
    var path: String {
        switch self {
        case .getDisplayReview(let displayId):
            return Const.URL.showDisplayReview + "/\(displayId)"
            // 희수는 Const.URL.display + "/\(order)/\(page)"
            
            
        }
    }
    
   // 어떤 타입인지 (Post, Get, Delete,
    var method: Moya.Method {
        switch self {
        case .getDisplayReview:
            return .get
            
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    // POST일 경우 보낼 데이터를 여기 적어
   // get은 그냥 .requestPlain
    var task: Task {
        switch self {
        case .getDisplayReview:
            return .requestPlain
            
        }
    }
    
// 헤더 - Content-Type이랑 Authorization
    var headers: [String: String]? {
        
        switch self {
        case .getDisplayReview:
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "jwtToken") ?? "")"
            ]
        }
    }
}
