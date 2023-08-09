//
//  MovieModel.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 04/08/23.
//

import Foundation

struct PageList<Item>: Codable {
    let page: Int
    let results: [Movie]
}

struct Movie: Codable, Identifiable {
    let title: String
    let id: Int
    let backdropPath: String
    let voteAverage: Double
    let overview: String
    let posterPath: String
    let releaseDate: String

    enum CodingKeys: String, CodingKey {
        case title
        case id
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}
