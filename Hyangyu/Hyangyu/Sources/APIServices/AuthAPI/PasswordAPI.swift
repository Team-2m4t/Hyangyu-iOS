//
//  PasswordAPI.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/02/03.
//

import Foundation
import Moya

public class PasswordAPI {
    
    static let shared = PasswordAPI()
    var courseProvider = MoyaProvider<PasswordService>()
    
    public init() { }
    
    func putNewPassword(completion: @escaping (NetworkResult<Any>) -> Void, email: String, password: String) {
        courseProvider.request(.putChangedPassword(email: email, password: password)) { (result) in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeChangePasswordStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func getEmailCode(completion: @escaping (NetworkResult<Any>) -> Void, email: String) {
        courseProvider.request(.getEmailCode(email: email)) { (result) in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeGetEmailCodeStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    // MARK: - judging status functions
    
    private func judgeChangePasswordStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<SignIn>.self, from: data) else {
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
    
    private func judgeGetEmailCodeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<CodeData>.self, from: data) else {
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

