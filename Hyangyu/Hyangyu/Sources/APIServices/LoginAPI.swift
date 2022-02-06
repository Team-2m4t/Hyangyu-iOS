//
//  LoginAPI.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/26.
//

import Foundation
import Moya

public class LoginAPI {
    
    static let shared = LoginAPI()
    var loginProvider = MoyaProvider<LoginService>()
    
    public init() { }
    
    func postSignIn(completion: @escaping (NetworkResult<Any>) -> Void, email: String, password: String) {
        loginProvider.request(.postSignIn(email: email, password: password)) { (result) in
            
            switch result {
            case.success(let response):
                
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, SignIn.self)

                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
            
        }
    }
    
    private func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data,  _ object: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
            let welcom = try? decoder.decode(SignIn.self, from: data)
            print(welcom)
        guard let decodedData = try? decoder.decode(GenericResponse<SignIn>.self, from: data as Data)
        
        else {
            return .pathErr
        }
        
        switch statusCode {
        case 200:
            return .success(welcom)
        case 400..<500:
            return .requestErr(decodedData.message)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
}
