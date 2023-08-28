//
//  String+Extensions.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 21/08/23.
//

import Foundation

extension Date {

    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"

        return dateFormatter.string(from: self)
    }

}
