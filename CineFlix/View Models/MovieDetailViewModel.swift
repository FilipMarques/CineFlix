//
//  MovieDetailViewModel.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 08/08/23.
//

import Foundation

class MovieDetailViewModel: ObservableObject {

    @Published var overview: String
    @Published var posterPath: String
    @Published var releaseDate: String

    init(overview: String, posterPath: String, releaseDate: String) {
        self.overview = overview
        self.posterPath = posterPath
        self.releaseDate = releaseDate
    }

    var formattedReleaseDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: releaseDate) {
            dateFormatter.dateFormat = "dd/MM/yyyy"
            return dateFormatter.string(from: date)
        } else {
            return releaseDate
        }
    }

}
