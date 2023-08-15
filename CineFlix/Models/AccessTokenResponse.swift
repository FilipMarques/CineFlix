//
//  AccessTokenResponse.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 13/08/23.
//

import Foundation

struct AccessTokenResponse: Decodable {
    let accessToken: String
    let accountId: String
    let statusCode: Int
    let statusMessage: String
    let success: Bool

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case accountId = "account_id"
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success
    }
}

