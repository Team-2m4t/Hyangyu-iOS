//
//  GetPersonDataService.swift
//  Hyangyu
//
//  Created by 길태연 on 2022/02/07.
//

import Foundation
import Alamofire

struct GetReviewDataService {
    static let shared = GetReviewDataService()
    var httpUrl: String?
    mutating func urlUrl(url: String) {
        httpUrl = url
    }
    
    func getExhibitionInfo(completion : @escaping (ReviewNetworkResult<Any>) -> Void) {
        let URL = "http://52.79.236.231:8080/api/show/review/display/2"
        
        let header: HTTPHeaders = ["Content-Type": "application/json"]
        
        let dataRequest = AF.request(URL, method: .get, encoding: JSONEncoding.default, headers: header )
            
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
    
    func getFairInfo(completion : @escaping (ReviewNetworkResult<Any>) -> Void) {
        let URL = "https://api.themoviedb.org/3/movie/11/reviews?api_key=227dee86e48bc552eb003429f225f5b1&language=en-US&page=1"
        
        let header: HTTPHeaders = ["Content-Type": "application/json"]
        
        let dataRequest = AF.request(URL, method: .get, encoding: JSONEncoding.default, headers: header )
            
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
    func getFestivalInfo(completion : @escaping (ReviewNetworkResult<Any>) -> Void) {
        let URL = "https://api.themoviedb.org/3/movie/14/reviews?api_key=227dee86e48bc552eb003429f225f5b1&language=en-US&page=1"
        
        let header: HTTPHeaders = ["Content-Type": "application/json"]
        
        let dataRequest = AF.request(URL, method: .get, encoding: JSONEncoding.default, headers: header )
            
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
    
        private func judgeStatus(by statusCode: Int, _ data: Data) -> ReviewNetworkResult<Any> {
            
            switch statusCode {
            
            case 200: print("1")
                ;return isValidData(data: data)
            case 400: return .pathErr
            case 500: return .serverErr
            default: return .networkFail
            }
            
        }
        private func isValidData(data: Data) -> ReviewNetworkResult<Any> {
            let decoder = JSONDecoder()
            
            guard let decodedData = try? decoder.decode(ReviewAPIDataModel.self, from: data)
            else { return.pathErr}
            
         //   decodedData.results
            return .success(decodedData.data)
        }
        
    }
    
