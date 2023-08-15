//
//  SessionIdResponse.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 14/08/23.
//

import Foundation

class SessionIdResponse: Decodable {
    let success: Bool
    let customSessionId: String

    enum CodingKeys: String, CodingKey {
        case success
        case customSessionId = "session_id"
    }
}
