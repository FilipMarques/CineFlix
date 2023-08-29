//
//  MovieLoggedView.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 28/08/23.
//

import SwiftUI

struct MovieLoggedView: View {
    @StateObject private var viewModel: MovieLoggedViewModel
    @Binding var isLoggedInBinding: Bool

    init(accountId: String, isLoggedInBinding: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: MovieLoggedViewModel(account: accountId))
        _isLoggedInBinding = isLoggedInBinding
    }

    var body: some View {
        VStack {
            Text("Perfil do Usuário")
                .font(.title)
                .padding()
            
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
                .padding()

            Text("Usuário: \(viewModel.userProfile?.username ?? "")")
            Text("País: \(viewModel.userProfile?.iso3166_1 ?? "")")

            Spacer()

            Button(action: {
                viewModel.fetch()
                isLoggedInBinding = false
            }) {
                Text("Sair")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .padding(.bottom, 20)
        }
        .padding()
    }
}

