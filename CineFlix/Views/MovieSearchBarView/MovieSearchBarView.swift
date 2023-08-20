//
//  MovieSearchBarView.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 16/08/23.
//

import SwiftUI
import URLImage

struct MovieSearchBarView: View {

    @StateObject private var viewModel = MovieSearchBarViewModel()
    @State private var searchText = ""

    var filteredItems: [SearchBarResponse] {
        if !searchText.isEmpty {
            let movieNames = viewModel.allSearchMovies
            return movieNames
        } else {
            return []
        }
    }

    var body: some View {
        VStack {
            VStack {
                TextField("Search movies", text: $searchText)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .onChange(of: searchText) { newValue in
                        self.viewModel.newSearchOnTextChange(newValue)
                    }

                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 10)
                .opacity(searchText.isEmpty ? 0 : 1)
            }
            .padding()

            Divider()

            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.allSearchMovies, id: \.id) { movie in
                        HStack(spacing: 16) {
                            URLImage(
                                URL(string: "https://image.tmdb.org/t/p/w500/\(movie.posterPath ?? "")")!
                            ) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 120)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                            }

                            VStack(alignment: .leading, spacing: 4) {
                                Text(movie.title)
                                    .font(.headline)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(2)
                                    .padding(.bottom, 4)

                                Text(String(format: "Nota: %.2f", movie.voteAverage))
                                    .font(.subheadline)
                                    .foregroundColor(.gray)

                                Text("Data de Estreia: \(movie.releaseDate)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.horizontal, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .onAppear {
                            viewModel.itemDidAppear(movie, query: searchText)
                        }
                    }
                }
            }


        }
    }
}

