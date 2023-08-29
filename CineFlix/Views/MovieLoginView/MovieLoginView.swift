//
//  MovieLoginView.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 24/08/23.
//



import SwiftUI

struct MovieLoginView: View {
    @State private var isShowingWebView = false
    @StateObject private var viewModel = MovieAuthenticationViewModel()
    @Environment(\.openURL) var openURL
    @Binding var isLoggedInBinding: Bool

    var body: some View {
        ZStack {
            // Perguntar como adiciona imagem de fundo sem afetar a tabbar
            VStack {
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 2)
                    .padding(.top)

                Image("Movie3")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .padding(.top, 160)

                Button(action: {
                    viewModel.handleLoginButtonTap { url in
                        openURL(URL(string: "https://www.themoviedb.org/auth/access?request_token=\(viewModel.requestToken)")!)
                    }
                }) {
                    Text("Abrir URL de Login")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.top, 32)

                Spacer()
            }
        }
        .onOpenURL { url in
            viewModel.fetchAccessToken(viewModel.requestToken)
            isLoggedInBinding = true
        }
    }


}
