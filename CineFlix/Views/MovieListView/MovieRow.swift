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
            URLImage(URL(string: "https://image.tmdb.org/t/p/w500/\(movie.backdropPath)")!) { image in
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
                    .foregroundColor(.white)
                    .shadow(color: Color.black.opacity(0.7), radius: 1, x: 0, y: 1)

                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(String(format: "%.2f", movie.voteAverage))
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .shadow(color: Color.black.opacity(0.7), radius: 1, x: 0, y: 1)
                }
            }
            .padding()
        }
        .shadow(radius: 5)
        .frame(height: 200)
    }
}

