//
//  MovieTabbarView.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 15/08/23.
//

import SwiftUI

struct MovieTabbarView: View {

    private let storageManager = StorageManager()
    private let network = NetworkManager()
    @State private var isLoggedIn = false

    var body: some View {
        TabView {
            NavigationView {
                MovieListView()
            }
            .tabItem {
                Image(systemName: "1.circle")
                Text("Aba 1")
            }

            Text("Segunda Aba")
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Aba 2")
                }

            NavigationView {
                MovieSearchBarView()
            }
            .tabItem {
                Image(systemName: "3.circle")
                Text("Aba 3")
            }
            NavigationView {
                if isLoggedIn {
                    Text("Logado")
                } else {
                    MovieLoginView()
                }
            }
            .tabItem {
                Image(systemName: "4.circle")
                Text("Aba 4")
            }
        }
        .onAppear {
            network.fetchAccessToken(requestToken: storageManager.getResquetToken() ?? "") { response in
                if response.success {
                    storageManager.setAccessToken(accessToken: response.accessToken)
                    isLoggedIn = true
                } else {
                    storageManager.setAccessToken(accessToken: nil)
                    isLoggedIn = false
                }

            }
        }
    }
}
