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

    init() {
        search(query: "batman")
    }

    func search(query: String) {
        networkManager.fetchSearchResults(query: query, page: 1) { response in
            self.allSearchMovies = response.results
        }
    }
}
