//
//  JsonDecoder+Extensions.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 21/08/23.
//

import Foundation

extension JSONDecoder {
    static var `default`: JSONDecoder = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)

        return decoder
    }()
}
