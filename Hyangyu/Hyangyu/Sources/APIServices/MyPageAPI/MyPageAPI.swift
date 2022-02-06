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
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data,  _ object: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
            let welcome = try? decoder.decode(SignIn.self, from: data)
        guard let decodedData = try? decoder.decode(GenericResponse<SignIn>.self, from: data as Data)
        
        else {
            return .pathErr
        }
        
        switch statusCode {
        case 200:
            return .success(welcome)
        case 400..<500:
            return .requestErr(decodedData.message)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
}
