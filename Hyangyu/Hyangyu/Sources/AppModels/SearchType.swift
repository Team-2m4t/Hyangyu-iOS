//
//  Search.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/30.
//

import Foundation

enum SearchType {
    case popular
    case recent
    case fileShort

    var description: String {
        switch self {
        case .popular: return "인기 검색어"
        case .recent: return "최근 검색어"
        case .fileShort: return "추천 검색어"
        }
    }

    var emptySentence: String {
        switch self {
        case .popular: return ""
        case .fileShort: return "추천 상품이 없습니다."
        case .recent: return "최근 검색어가 없습니다."
        }
    }
}   

