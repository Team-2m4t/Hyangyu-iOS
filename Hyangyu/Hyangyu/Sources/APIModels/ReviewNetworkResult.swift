//
//  ReviewNetworkResult.swift
//  Hyangyu
//
//  Created by 길태연 on 2022/02/07.
//

import Foundation

enum ReviewNetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
