//
//  ShowReviewAPI.swift
//  Hyangyu
//
//  Created by 홍희수 on 2022/02/10.
//

import Foundation
import Moya

public class ShowReviewAPI {
    
    static let shared = ShowReviewAPI()
    var savedProvider = MoyaProvider<ShowReviewService>()
    
    public init() { }
    
    func getDisplayReview(displayId: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        savedProvider.request(.getDisplayReview(displayId: displayId)) { (result) in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<ReviewDisplayResponse>.self, from: data)
        else {
            return .pathErr
        }
        
        switch statusCode {
        case 200:
            //print(decodedData.data)
            return .success(decodedData.data)
        case 400..<500:
            return .requestErr(decodedData.message)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
}
