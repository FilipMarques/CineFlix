//
//  MoviefView.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 14/09/23.
//

import SwiftUI
import URLImage

struct MovieFavoriteView: View {

    @StateObject private var viewModel: MovieFavoriteViewModel

    init(accountId: String) {
        _viewModel = StateObject(wrappedValue: MovieFavoriteViewModel(accountId: accountId))
    }

    var body: some View {
        List(viewModel.favoritesMovie) { movie in
            MovieFavoriteRow(movie: movie)
        }
        .navigationTitle("Meus Favoritos")
        .onAppear {
            viewModel.fetchFavoritesMovie()
        }
    }
}

struct MovieFavoriteRow: View {
    var movie: FavoriteMovie

    @State private var isExpanded: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top, spacing: 16) {
                URLImage(URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)")!) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 120)
                        .cornerRadius(10)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(movie.title)
                        .font(.headline)

                    Text("Data de Lançamento: \(movie.releaseDate)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }

            if isExpanded {
                Text(movie.overview)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(radius: 5)
        )
        .onTapGesture {
            withAnimation {
                isExpanded.toggle()
            }
        }
    }
}
