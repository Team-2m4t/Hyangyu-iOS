//
//  MyPageAPI.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/02/07.
//

import Foundation
import Moya

public class MyPageAPI {
    
    static let shared = MyPageAPI()
    var myPageProvider = MoyaProvider<MyPageService>()
    
    public init() { }
    
    func modifyUserName(completion: @escaping (NetworkResult<Any>) -> Void, email: String, password: String, nickname: String) {
        myPageProvider.request(.modifyUserName(email: email, password: password, nickname: nickname)) {
            (result) in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, ModifyCheckData.self)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func getUserData(completion: @escaping (NetworkResult<Any>) -> Void) {
        myPageProvider.request(.getUserData) { (result) in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, MyPageResponse.self)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data,  _ object: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<T>.self, from: data as Data)
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
