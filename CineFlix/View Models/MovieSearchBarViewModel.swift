//
//  MovieSearchBarViewModel.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 16/08/23.
//

import Foundation

class MovieSearchBarViewModel: ObservableObject {

    @Published var currentPage = 1
    @Published var allSearchMovies: [SearchBarResponse] = []

    private var networkManager = NetworkManager()

    func paginateIfNeeded(_ movie: SearchBarResponse, query: String) {
        if movie.title == allSearchMovies.last?.title {
            currentPage += 1
            search(query, currentPage)
        }
    }

    func newSearchOnTextChange(_ query: String) {
        allSearchMovies = []
        currentPage = 1
        search(query, currentPage)
    }

    private func search(_ query: String, _ currentPage: Int) {
        networkManager.fetchSearchResults(query: query, page: currentPage) { [weak self] response in
            guard let self else { return }
            self.allSearchMovies.append(contentsOf: response.results)
        }
    }
}
