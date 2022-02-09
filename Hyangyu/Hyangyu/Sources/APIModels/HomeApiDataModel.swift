//
//  HomeApiDataModel.swift
//  Hyangyu
//
//  Created by 길태연 on 2022/02/09.
//

import Foundation

// MARK: - Welcome
struct HomeApiDataModel: Codable {
    let page: Int
    let results: [Home]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Home: Codable {
    let originalLanguage: OriginalLanguage
    let posterPath, firstAirDate: String
    let id: Int
    let voteAverage: Double
    let name, overview, originalName: String
    let originCountry: [String]
    let backdropPath: String
    let voteCount: Int
    let genreIDS: [Int]
    let popularity: Double
    let mediaType: MediaType

    enum CodingKeys: String, CodingKey {
        case originalLanguage = "original_language"
        case posterPath = "poster_path"
        case firstAirDate = "first_air_date"
        case id
        case voteAverage = "vote_average"
        case name, overview
        case originalName = "original_name"
        case originCountry = "origin_country"
        case backdropPath = "backdrop_path"
        case voteCount = "vote_count"
        case genreIDS = "genre_ids"
        case popularity
        case mediaType = "media_type"
    }
}

enum MediaType: String, Codable {
    case tv = "tv"
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case es = "es"
    case ja = "ja"
    case ko = "ko"
}
