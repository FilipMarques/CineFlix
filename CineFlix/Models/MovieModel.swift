//
//  MovieModel.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 04/08/23.
//

import Foundation

struct MovieModel: Codable {
    let page: Int
    let results: [Movie]
}

struct Movie: Codable, Identifiable {
    let title: String
    let id: Int
    let backdrop_path: String
    let vote_average: Double
    let overview: String
    let poster_path: String
    let release_date: String
}
