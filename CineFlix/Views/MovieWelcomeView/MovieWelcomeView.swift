//
//  MovieWelcomeView.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 14/08/23.
//

import SwiftUI

struct MovieWelcomeView: View {
    @StateObject private var viewModel = MovieAuthenticationViewModel()
    @State private var urlToOpen: URL?
    @State private var showTabBar = false
    @Environment(\.openURL) var openURL

    var body: some View {
        NavigationView {
            ZStack {
                backgroundImage
                welcomeContent
            }
            .navigationBarHidden(true)
        }
        .onOpenURL { url in
            urlToOpen = url
            viewModel.fetchAccessToken(viewModel.requestToken) { success in
                if success {
                    showTabBar = true
                }
            }
        }
        .fullScreenCover(isPresented: $showTabBar) {
            MovieTabbarView()
        }
    }

    private var backgroundImage: some View {
        Image("Movie")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
    }

    private var welcomeContent: some View {
        VStack(spacing: 20) {
            Spacer()

            Text("Bem-vindo ao CineFlix")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .background(Color.black.opacity(0.5))
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 2)

            Spacer()

            Button(action: {
                viewModel.handleLoginButtonTap { url in
                    openURL(URL(string: "https://www.themoviedb.org/auth/access?request_token=\(viewModel.requestToken)")!)
                }
            }) {
                Text("Entrar")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.blue)
                            .shadow(color: Color.blue.opacity(0.7), radius: 5, x: 0, y: 2)
                    )
            }
            .padding(.horizontal, 20)
        }
    }
    
}
