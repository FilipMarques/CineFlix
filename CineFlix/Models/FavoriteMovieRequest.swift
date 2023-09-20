//
//  FavoriteMovieRequest.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 19/09/23.
//

import Foundation

struct FavoriteMovieRequest: Encodable {
    let mediaType: String
    let mediaId: Int
    let favorite: Bool

    enum CodingKeys: String, CodingKey {
        case mediaType = "media_type"
        case mediaId = "media_id"
        case favorite
    }
}
