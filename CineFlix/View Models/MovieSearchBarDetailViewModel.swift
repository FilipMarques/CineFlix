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
        fetchMovieDetails()
    }

    func fetchMovieDetails() {
        networkManager.fetchMovieDetails(movieId) { [weak self] response in
            guard let self else { return }
            self.movieDetailsResponse = response
        }
    }

}
