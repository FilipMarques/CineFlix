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

struct PercentageCircle: View {
    @State var percentage: CGFloat

    var body: some View {
        VStack {
            Text("\(Int(percentage * 100))%")

            ZStack {
                Circle()
                    .stroke(lineWidth: 2.5)
                    .opacity(0.3)
                    .foregroundColor(Color.gray)

                Circle()
                    .trim(from: 0, to: percentage)
                    .stroke(style: StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.blue)
                    .rotationEffect(Angle(degrees: -95))
                    .animation(.easeInOut(duration: 1.0))
            }
            .frame(width: 25, height: 25)

            Button(action: {
                withAnimation {
                    self.percentage = CGFloat.random(in: 0.0...1.0)
                }
            }) {
                Text("Animate")
            }
        }
        .padding()
    }
}
