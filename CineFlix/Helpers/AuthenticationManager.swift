//
//  AuthenticationManager.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 16/08/23.
//

import Foundation
import Combine

class AuthenticationManager {

    static let shared = AuthenticationManager()
    private let refreshPublisher = PassthroughSubject<Void, Never>()

    func refresh() {
        refreshPublisher.send(())
    }

    func publisher() -> AnyPublisher<Void, Never> {
        refreshPublisher.eraseToAnyPublisher()
    }
}
