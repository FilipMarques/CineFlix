//
//  ContentView.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 03/08/23.
//

import SwiftUI

struct MovieList: View {

    @StateObject private var viewModel = MovieListViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.allMovies) { movie in
                NavigationLink(destination: MovieDetail(overview: movie.overview,
                                                        poster_path: movie.poster_path,
                                                        release_date: movie.release_date)) {
                    MovieRow(movie: movie)
                        .onAppear {
                            viewModel.itemDidAppear(movie)
                        }
                }
            }
            .frame(width: UIScreen.main.bounds.width)
            .navigationTitle("Filmes")

        }
        .onAppear {
            viewModel.loadData()
        }
        
    }
}
