//
//  SignUpAPI.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/26.
//

import Foundation
import Moya

public class SignUpAPI {
    
    static let shared = SignUpAPI()
    var signupProvider = MoyaProvider<SignUpService>()
    
    public init() { }
    


    
    func postSignUp(completion: @escaping (NetworkResult<Any>) -> Void, email: String, password: String, nickname: String) {
        signupProvider.request(.postSignUp(email: email, password: password, nickname: nickname)) { (result) in
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
    

  
    func deleteUser(completion: @escaping ((NetworkResult<Any>) -> Void)) {
        signupProvider.request(.deleteUser) { (result) in
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
        guard let decodedData = try? decoder.decode(GenericResponse<SignIn>.self, from: data)
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
