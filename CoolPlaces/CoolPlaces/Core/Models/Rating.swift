//
//  Rating.swift
//  CoolPlaces
//
//  Created by Elano Vasconcelos on 29/11/24.
//

import Foundation

struct Rating: Codable {
    let overall: Int
    let atmosphere: Int
    let cleanliness: Int
    let facilities: Int
    let staff: Int
    let security: Int
    let location: Int
    let valueForMoney: Int
}
