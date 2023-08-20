//
//  MovieSearchBarResponse.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 16/08/23.
//

import Foundation

struct SearchBarResponse: Identifiable, Codable {
    let adult: Bool
    let backdropPath: String?
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

struct SearchCollection: Codable {
    let page: Int
    let results: [SearchBarResponse]
}
