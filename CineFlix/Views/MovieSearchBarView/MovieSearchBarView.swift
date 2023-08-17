//
//  MovieSearchBarView.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 16/08/23.
//

import SwiftUI

struct MovieSearchBarView: View {
    
    @StateObject private var viewModel = MovieSearchBarViewModel()
    @State private var searchText = ""

    var filteredItems: [String] {
        if !searchText.isEmpty {
            let movieNames = viewModel.allSearchMovies.map { $0.name }
            return movieNames.filter { $0.localizedCaseInsensitiveContains(searchText) }
        } else {
            return []
        }
    }

    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.allSearchMovies) { response in
                    Text("Item \(response.name)")
                        .font(.title)
                        .padding()
                }
            }
        }
    }
}

struct MovieSearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchBarView()
    }
}
