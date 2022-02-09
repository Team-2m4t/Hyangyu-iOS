//
//  SavedAPI.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/02/08.
//

import Foundation

import Moya

public class SavedAPI {
    
    static let shared = SavedAPI()
    var savedProvider = MoyaProvider<SavedService>()
    
    public init() { }
    
    func getMyDisplay(page: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        savedProvider.request(.getMyDisplay(page: page)) { (result) in
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
        guard let decodedData = try? decoder.decode(GenericResponse<SavedResponse>.self, from: data)
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
