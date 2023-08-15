//
//  RequestTokenModel.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 11/08/23.
//

struct RequestTokenResponse: Codable {
    let requestToken: String
    let statusCode: Int
    let statusMessage: String
    let success: Bool

    enum CodingKeys: String, CodingKey {
        case requestToken = "request_token"
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success
    }
}
