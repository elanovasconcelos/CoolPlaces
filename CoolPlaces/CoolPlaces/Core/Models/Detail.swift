//
//  Detail.swift
//  CoolPlaces
//
//  Created by Elano Vasconcelos on 29/11/24.
//

import Foundation

struct Detail: Codable {
    let id: String
    let name: String
    let rating: Rating?
    let description: String?
    let address1: String?
    let address2: String?
    let directions: String?
    let city: City?
    let totalRatings: String?
    let images: [PropertyImage]?
    let type: String?
}
