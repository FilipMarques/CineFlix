//
//  MovieSearchBarDetailViewModel.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 21/08/23.
//

import Foundation

class MovieSearchBarDetailViewModel: ObservableObject {

    private let networkManager = NetworkManager()

    @Published var movieDetailsResponse: MovieDetailsResponse?
    @Published var formattedReleaseDate: String?

    private let movieId: Int

    init(movieId: Int) {
        self.movieId = movieId
        fetchMovieDetails(for: movieId)
    }

    func fetchMovieDetails(for movieId: Int) {
        networkManager.fetchMovieDetails(movieId) { response in
            self.movieDetailsResponse = response
        }
    }

    private func formatDate(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let date = dateFormatter.date(from: dateString) {
            let formattedDate = DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .none)
            return formattedDate
        }
        return nil
    }
}
