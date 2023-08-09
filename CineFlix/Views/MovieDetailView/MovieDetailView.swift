//
//  MovieDetail.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 08/08/23.
//

import SwiftUI
import URLImage

struct MovieDetailView: View {

    @StateObject private var viewModel: MovieDetailViewModel

    init(overview: String, posterPath: String, releaseDate: String) {
        _viewModel = .init(wrappedValue: MovieDetailViewModel(
            overview: overview,
            posterPath: posterPath,
            releaseDate: releaseDate
        ))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                URLImage(URL(string: "https://image.tmdb.org/t/p/w500/\(viewModel.posterPath)")!) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .frame(maxWidth: .infinity)

                Text("Data de lançamento: \(viewModel.formattedReleaseDate)")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Text("Visão Geral")
                    .font(.headline)

                Text(viewModel.overview)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(8)

                Spacer()
            }
            .padding()
            .navigationBarTitle("Informações do Filme", displayMode: .inline)
        }
    }
}
