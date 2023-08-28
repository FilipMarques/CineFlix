//
//  MovieWebviewViewModel.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 11/08/23.
//

import Foundation

class MovieAuthenticationViewModel: ObservableObject {

    @Published var requestToken: String = ""

    private var networkManager = NetworkManager()
    private let storageManager = StorageManager()

    func fetchRequestToken(completion: @escaping (Bool) -> Void) {
        if requestToken.isEmpty {
            networkManager.fetchRequestToken { [weak self] response in
                DispatchQueue.main.async  {
                    self?.requestToken = response.requestToken
                    completion(true)
                }
            }
        }
    }
    
    func fetchAccessToken(_ token: String) {
        networkManager.fetchAccessToken(requestToken: token) { [weak self] response in
            DispatchQueue.main.async {
                self?.storageManager.setAccessToken(accessToken: response.accessToken)
                AuthenticationManager.shared.refresh()
            }
        }
    }

    func handleLoginButtonTap(openURL: @escaping (URL) -> Void) {
        if requestToken.isEmpty {
            fetchRequestToken { [weak self] success in
                guard let self else { return }
                if success, let url = URL(string: "https://www.themoviedb.org/auth/access?request_token=\(self.requestToken)") {
                    openURL(url)
                } else {
                    print("Something went wrong while fetching request token.")
                }
            }
        } else {
            print("Request token already available: \(self.requestToken)")
        }
    }

}
