//
//  MovieSearchBarResponse.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 16/08/23.
//

import Foundation

struct SearchBarResponse: Identifiable, Codable {
    let id: Int
    let adult: Bool
    let backdropPath: String?
    let name: String
    let originalLanguage: String
    let originalName: String
    let overview: String
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case id, adult, name, overview
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case posterPath = "poster_path"
    }
}

struct SearchCollection: Codable {
    let page: Int
    let results: [SearchBarResponse]
}
