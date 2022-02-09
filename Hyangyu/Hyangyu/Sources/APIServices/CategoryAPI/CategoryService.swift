//
//  GetCategoryDataService.swift
//  Hyangyu
//
//  Created by 홍희수 on 2022/02/09.
//

import Foundation
import Moya

// 내가 저장한 전시회,박람회, 페스티벌 관련 서비스
enum CategoryService {
    
    case getCategory(order: String, page: Int) // 내가 저장한 전시회 조회
    // 희수의 경우 카테고리 전시회 조회에 order: String과 page: Int가 필요하잖아?
    // 그럼 case <이름>(order: String, page: Int) 이렇게 해주면 된다
    
}

extension CategoryService: TargetType, AccessTokenAuthorizable {
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
        case .getCategory(let order, let page):
            return Const.URL.display + "/\(order)/\(page)"
        // 희수는 Const.URL.display + "/\(order)/\(page)"
        }
    }
    
    // 어떤 타입인지 (Post, Get, Delete,
    var method: Moya.Method {
        switch self {
        case .getCategory:
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
        case .getCategory:
            return .requestPlain
            
        }
    }
    
    // 헤더
    var headers: [String: String]? {
        
        switch self {
        case .getCategory:
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "jwtToken") ?? "")"
            ]
        }
    }
}
/*
import Alamofire


struct CategoryService
{
    static let shared = GetCategoryDataService()
    
    
    
    func getCategoryInfo(completion : @escaping (NetworkResult<Any>) -> Void)
    {
        // completion 클로저를 @escaping closure로 정의합니다.
        
        
        let URL = "http://52.79.236.231:8080/api/display/latest/0"
        let header : HTTPHeaders = ["Content-Type": "application/json"]
        
        let dataRequest = AF.request(URL,
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        
        dataRequest.responseData { dataResponse in
            
            
            switch dataResponse.result {
            case .success:
                                
                guard let statusCode = dataResponse.response?.statusCode else {return}
                guard let value = dataResponse.value else {return}
                let networkResult = self.judgeStatus(by: statusCode, value)
                completion(networkResult)
            
            case .failure: completion(.pathErr)
                
            }
        }
                                            
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
          
        switch statusCode {
        
        case 200: return isValidData(data: data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    
    
    private func isValidData(data : Data) -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()

        guard let decodedData = try? decoder.decode(CategoryLatest.self, from: data)
        else { return .pathErr}
        // 우선 PersonDataModel 형태로 decode(해독)을 한번 거칩니다. 실패하면 pathErr
        
        // 해독에 성공하면 Person data를 success에 넣어줍니다.
        return .success(decodedData.data)

    }
    
}
*/
