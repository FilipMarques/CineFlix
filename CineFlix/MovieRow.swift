//
//  MovieRow.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 04/08/23.
//

import SwiftUI
import URLImage

struct MovieRow: View {
    let movie: Movie

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            URLImage(URL(string: "https://image.tmdb.org/t/p/w500/\(movie.backdrop_path)")!) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()
                    .cornerRadius(12)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title)
                    .foregroundColor(.white)
                    .font(.title)
                    .bold()
                    .lineLimit(3)

                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(String(format: "%.2f", movie.vote_average))
                        .foregroundColor(.white)
                        .font(.subheadline)
                }
            }
            .padding()
        }
        .shadow(radius: 5)
        .frame(height: 200)
    }
}

