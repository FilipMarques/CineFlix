//
//  MovieListViewModel.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 08/08/23.
//

import Foundation

class MovieListViewModel: ObservableObject {

    @Published var currentPage = 1
    @Published var allMovies: [Movie] = []

    private var networkManager = NetworkManager()

    func loadData() {
        fetchData(currentPage)
    }

    func itemDidAppear(_ movie: Movie) {
        if movie.title == allMovies.last?.title {
            fetchData(currentPage)
        }
    }

    private func fetchData(_ currentPage: Int) {
        networkManager.fetchData(page: currentPage) { [weak self] fetchedMovies in
            self?.allMovies.append(contentsOf: fetchedMovies)
            self?.currentPage += 1
        }
    }

}
