//
//  MovieListViewModel.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 08/08/23.
//

import SwiftUI

class MovieListViewModel: ObservableObject {

    @Published var currentPage = 1
    @Published var allMovies: [Movie] = []
    private var isFirstTime = true

    private var networkManager = NetworkManager()
    private var storageManager = StorageManager()

    func loadData() {
        if self.isFirstTime {
            fetchData(1)
            self.isFirstTime = false
        }
    }

    func itemDidAppear(_ movie: Movie) {
        if movie.title == allMovies.last?.title {
            fetchData(currentPage)
        }
    }

    func addFavoriteMovie(mediaId: Int, isFavorite: Bool) {
        networkManager.favoriteMovie(accountId: storageManager.getAccountId() ?? "", mediaId: mediaId, isFavorite: isFavorite) { result in
            switch result {
            case .success(()):
                print("deu bom")
            case .failure(let error):
                print(error)
            }
        }
    }

    private func fetchData(_ currentPage: Int) {
        networkManager.fetchDataMoviesDetails(page: currentPage) { [weak self] fetchedMovies in
            self?.allMovies.append(contentsOf: fetchedMovies)
            self?.currentPage += 1
        }
    }

}
