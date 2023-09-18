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
    @State private var accountId: String? // deixar opcional fazer a condição isLoggedIn por if let
    @State private var isLoggedIn = false

    var body: some View {
        TabView {
            NavigationView {
                MovieListView()
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Aba 1")
            }

            NavigationView {
                MovieFavoriteView(accountId: storageManager.getAccountId() ?? "")
            }
            .tabItem {
                Image(systemName: "star.fill")
                Text("Aba 2")
            }

            NavigationView {
                MovieSearchBarView()
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Aba 3")
            }
            
            NavigationView {
                if isLoggedIn {
                    MovieLoggedView(accountId: storageManager.getAccountId() ?? "", isLoggedInBinding: $isLoggedIn)
                } else {
                    MovieLoginView(isLoggedInBinding: $isLoggedIn)
                }
            }
            .tabItem {
                Image(systemName: "person.circle.fill")
                Text("Aba 4")
            }
        }
        .onAppear {
            handleAuthentication()
        }
    }

    func handleAuthentication() {
        if let requestToken = storageManager.getAccessToken() {
            network.fetchAccessToken(requestToken: requestToken) { response in
                if response.success {
                    storageManager.setAccessToken(accessToken: response.accessToken)
                    storageManager.setAccountId(accountId: response.accountId)
                    isLoggedIn = true
                    print("\(response)")
                } else {
                    storageManager.setAccessToken(accessToken: nil)
                    storageManager.setAccountId(accountId: nil)
                    isLoggedIn = false
                }

            }
        } else {
            network.fetchRequestToken { response in
                if response.success {
                    network.fetchAccessToken(requestToken: response.requestToken) { response in
                        if response.success {
                            storageManager.setAccessToken(accessToken: response.accessToken)
                            storageManager.setAccountId(accountId: response.accountId)
                            self.isLoggedIn = true
                            print("\(response)")
                        } else {
                            storageManager.setAccessToken(accessToken: nil)
                            storageManager.setAccountId(accountId: nil)
                            isLoggedIn = false
                        }

                    }
                }
            }
        }
    }
}


