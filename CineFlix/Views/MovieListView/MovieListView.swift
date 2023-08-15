//
//  ContentView.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 03/08/23.
//

import SwiftUI

struct MovieListView: View {

    @StateObject private var viewModel = MovieListViewModel()

    var body: some View {

        List(viewModel.allMovies) { movie in
            NavigationLink(destination: MovieDetailView(overview: movie.overview,
                                                        posterPath: movie.posterPath,
                                                        releaseDate: movie.releaseDate)) {
                MovieRow(movie: movie)
                    .onAppear {
                        viewModel.itemDidAppear(movie)
                    }
            }
        }
        .frame(width: UIScreen.main.bounds.width)
        .navigationTitle("Filmes")
        .onAppear {
            viewModel.loadData()
        }

    }
}
