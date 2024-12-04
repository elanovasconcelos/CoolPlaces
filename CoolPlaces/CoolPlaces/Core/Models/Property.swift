//
//  Property.swift
//  CoolPlaces
//
//  Created by Elano Vasconcelos on 29/11/24.
//

import Foundation

struct Property: Codable, Identifiable {
    let id: String
    let name: String
    let city: City
    let latitude: String
    let longitude: String
    let type: String
    let images: [PropertyImage]
    let overallRating: OverallRating
}
