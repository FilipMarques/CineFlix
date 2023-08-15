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

    func fetchRequestToken(completion: @escaping (Bool) -> Void) {
        networkManager.fetchRequestToken { [weak self] response in
            DispatchQueue.main.async  {
                self?.requestToken = response.requestToken
                completion(true)
            }
        }
    }

    func fetchAccessToken(_ token: String, completion: @escaping (Bool) -> Void) {
        networkManager.fetchAccessToken(requestToken: token) { response in
            DispatchQueue.main.async {
                completion(true)
            }
        }
    }

    func handleLoginButtonTap(openURL: @escaping (URL) -> Void) {
        if requestToken.isEmpty {
            fetchRequestToken { success in
                if success, let url = URL(string: "https://www.themoviedb.org/auth/access?request_token=\(self.requestToken)") {
                    openURL(url)
                } else {
                    print("Something went wrong while fetching request token.")
                }
            }
        } else {
            print("Request token already available: \(requestToken)")
        }
    }

}
