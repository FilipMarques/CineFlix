//
//  MovieSearchBarDetailView.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 21/08/23.
//

import SwiftUI
import URLImage

struct MovieSearchBarDetailView: View {

    @StateObject private var viewModel: MovieSearchBarDetailViewModel

    init(movieId: Int) {
        _viewModel = .init(wrappedValue: MovieSearchBarDetailViewModel(movieId: movieId))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(viewModel.movieDetailsResponse?.title ?? "")
                    .font(.title)

                if let releaseDate = viewModel.formattedReleaseDate {
                    Text("Lançamento: \(releaseDate)")
                        .foregroundColor(.gray)
                }

                if let posterURL = viewModel.movieDetailsResponse?.posterPath {
                    URLImage(URL(string: "https://image.tmdb.org/t/p/w500/\(posterURL)")!) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width - 40, height: 200)

                    }
                }

                Text(viewModel.movieDetailsResponse?.overview ?? "")
                    .font(.body)

                Text("Avaliação: \(viewModel.movieDetailsResponse?.voteAverage ?? 0, specifier: "%.2f")")

                Text("Duração: \(viewModel.movieDetailsResponse?.runtime ?? 0) minutos")
            }
            .padding()
        }
        .navigationBarTitle(viewModel.movieDetailsResponse?.title ?? "", displayMode: .inline)
    }
}

