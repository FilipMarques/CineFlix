//
//  CineFlixApp.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 03/08/23.
//

import SwiftUI

@main
struct CineFlixApp: App {

    private let storageManager = StorageManager()
    @State var authenticationSeed = UUID() // dar uma olhada mais afundo no UUID()
//    @State private var isValidToken: Bool = false

    private var networkManager = NetworkManager()

    func checkToken() -> Bool {
        _ = authenticationSeed
        return storageManager.getResquetToken() != nil
    }

    var body: some Scene {
        WindowGroup {
            MovieTabbarView()
//            NavigationView {
//                if checkToken() {
//                    MovieTabbarView()
//                } else {
//                    MovieWelcomeView()
//                }
//            }
//            .onReceive(AuthenticationManager.shared.publisher()) {
//                authenticationSeed = UUID()
//            }
//            .onAppear {
//                storageManager.setAccessToken(accessToken: nil)
//            }
        }
    }
}
