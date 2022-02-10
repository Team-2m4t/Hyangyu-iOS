//
//  ReviewAPI.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/02/10.
//

import Foundation

import Moya

public class ReviewAPI {
    
    static let shared = ReviewAPI()
    var reviewProvider = MoyaProvider<ReviewService>()
    
    public init() { }
    


    
    func postDisplayReview(displayId: Int, content: String, score: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        reviewProvider.request(.postDisplayReview(displayId: displayId, content: content, score: score)) { (result) in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                print(data, statusCode)
                
                let networkResult = self.judgeStatus(by: statusCode, data)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }

    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<String>.self, from: data)
        else {
            return .pathErr
        }
        
        switch statusCode {
        case 200:
            return .success(decodedData.message)
        case 400..<500:
            return .requestErr(decodedData.message)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
}
