//
//  HomeGetDataService.swift
//  Hyangyu
//
//  Created by 길태연 on 2022/02/09.
//

import Foundation
import Alamofire

struct HomeGetDataService {
    static let shared = HomeGetDataService()
    
    func getDataInfo(completion : @escaping (NetworkResult<Any>) -> Void){
        
        let URL = "https://api.themoviedb.org/3/trending/tv/week?api_key=227dee86e48bc552eb003429f225f5b1"
        let header : HTTPHeaders = ["Content-Type": "application/json"]
        
        let dataRequest = AF.request(URL, method: .get,encoding: JSONEncoding.default, headers: header)
        
        dataRequest.responseData { dataResponse in
            
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else {return}
                guard let value = dataResponse.value else {return}
                let networkResult = self.judgeStatus(by: statusCode, value)
                completion(networkResult)
                print(dataResponse)
                
            case .failure: completion(.pathErr)
              //  print(dataResponse)
                
            }
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data : Data) -> NetworkResult<Any> {
        
        switch statusCode {
        
        case 200: print("1")
            ;return isValidData(data : data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
        
    }
    
    private func isValidData(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(HomeApiDataModel.self, from: data)
        else { return.pathErr}
        
     //   decodedData.results
        return .success(decodedData.results)
    }
    
}
