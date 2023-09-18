//
//  MovieFavoriteViewModel.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 15/09/23.
//

import Foundation

class MovieFavoriteViewModel: ObservableObject {

    private let networkManager = NetworkManager()
    private let storageManager = StorageManager()

    @Published var favoritesMovie: [FavoriteMovie] = []
    @Published var accountId: String

    init(accountId: String) {
        self.accountId = accountId
    }

    func fetchFavoritesMovie() {
        networkManager.fetchFavoritesMovies(accountId: storageManager.getAccountId() ?? "", page: 1) { [weak self] result in
            switch result {
            case .success(let response):
                self?.favoritesMovie = response.results
            case .failure(_):
                self?.favoritesMovie = []
            }

        }
    }

    
}
