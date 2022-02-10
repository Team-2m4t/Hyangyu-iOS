//
//  HomeNetworkResult.swift
//  Hyangyu
//
//  Created by 길태연 on 2022/02/09.
//

import Foundation
enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
