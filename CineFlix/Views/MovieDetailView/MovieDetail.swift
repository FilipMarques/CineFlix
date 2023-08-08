//
//  MovieDetail.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 08/08/23.
//

import SwiftUI
import URLImage

struct MovieDetail: View {
    let overview: String
    let poster_path: String
    let release_date: String

    var formattedReleaseDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: release_date) {
            dateFormatter.dateFormat = "dd/MM/yyyy"
            return dateFormatter.string(from: date)
        } else {
            return release_date
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                URLImage(URL(string: "https://image.tmdb.org/t/p/w500/\(poster_path)")!) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .frame(maxWidth: .infinity)

                Text("Data de lançamento: \(formattedReleaseDate)")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Text("Visão Geral")
                    .font(.headline)

                Text(overview)
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
