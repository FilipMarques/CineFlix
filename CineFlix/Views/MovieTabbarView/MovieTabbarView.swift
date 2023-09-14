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

    func teste(completion: @escaping (Bool) -> (Void)) {
        if let requestToken = storageManager.getResquetToken() {
            network.fetchAccessToken(requestToken: requestToken) { response in
                if response.success {
                    storageManager.setAccessToken(accessToken: response.accessToken)
                    self.accountId = response.accountId
                    isLoggedIn = true
                    print("\(response)")
                    completion(true)
                } else {
                    storageManager.setAccessToken(accessToken: nil)
                    isLoggedIn = false
                }

            }
        } else {
            network.fetchRequestToken { response in
                if response.success {
                    network.fetchAccessToken(requestToken: response.requestToken) { response in
                        if response.success {
                            storageManager.setAccessToken(accessToken: response.accessToken)
                            self.accountId = response.accountId
                            self.isLoggedIn = true
                            print("\(response)")
                        } else {
                            storageManager.setAccessToken(accessToken: nil)
                            isLoggedIn = false
                        }

                    }
                }
            }
        }
    }

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
                    MovieLoggedView(accountId: storageManager.getAccountId() ?? "", isLoggedInBinding: $isLoggedIn)
                } else {
                    MovieLoginView(isLoggedInBinding: $isLoggedIn)
                }
            }
            .tabItem {
                Image(systemName: "4.circle")
                Text("Aba 4")
            }
        }
        .onChange(of: accountId) { newValue in
            print("2")
        }
        .onAppear {
            print("eu")

        }
    }
}

//        .onChange(of: <#T##Equatable#>, perform: <#T##(Equatable) -> Void##(Equatable) -> Void##(_ newValue: Equatable) -> Void#>) // status do @state


