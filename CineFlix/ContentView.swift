//
//  ContentView.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 03/08/23.
//

import SwiftUI

struct ContentView: View {

    @State private var currentPage = 1
    @ObservedObject var networkManager = NetworkManager()

    var body: some View {
        NavigationView {
            List(networkManager.allMovies) { movie in
                MovieRow(movie: movie)
                    .onAppear {
                        if movie.title == networkManager.allMovies.last?.title {
                            self.currentPage += 1
                            networkManager.fetchData(page: currentPage)
                        }
                    }
            }
            .frame(width: UIScreen.main.bounds.width)
            .navigationTitle("Filmes")

            
        }
        .onAppear {
            networkManager.fetchData(page: currentPage)
        }
        
    }
}
