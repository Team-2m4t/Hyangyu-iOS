//
//  SearchAPI.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/02/10.
//

import Foundation

import Moya

public class SearchAPI {
    
    static let shared = SearchAPI()
    var searchProvider = MoyaProvider<SearchService>()
    
    public init() { }
    


    
    func search(keyword: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        searchProvider.request(.search(keyword: keyword)) { (result) in
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
        guard let decodedData = try? decoder.decode(GenericResponse<SearchResultResponse>.self, from: data)
        else {
            return .pathErr
        }
        
        switch statusCode {
        case 200:
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
