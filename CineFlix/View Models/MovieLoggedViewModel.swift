//
//  MovieLoggedViewModel.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 28/08/23.
//

import Foundation

class MovieLoggedViewModel: ObservableObject {
    private let networkManager = NetworkManager()
    private let storageManager = StorageManager()

    @Published var userProfile: UserProfile?
    @Published var accountId: String

    init(account: String) {
        self.accountId = account
        fetchUserProfile()
    }

    private func fetchUserProfile() {
        networkManager.fetchUserProfile(self.accountId) { [weak self] response in
            self?.userProfile = response
        }
    }

    func fetch() {
        networkManager.fetchLogoutRequest(accessToken: storageManager.getAccessToken() ?? "")
        storageManager.setAccessToken(accessToken: nil)
        storageManager.setAccountId(accountId: nil)
    }
}
