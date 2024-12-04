//
//  PropertyImage.swift
//  CoolPlaces
//
//  Created by Elano Vasconcelos on 29/11/24.
//

import Foundation

struct PropertyImage: Codable {
    let suffix: String
    let prefix: String
}

extension PropertyImage {
    var fullURL: URL? {
        return URL(string: "\(prefix)\(suffix)")
    }
}
