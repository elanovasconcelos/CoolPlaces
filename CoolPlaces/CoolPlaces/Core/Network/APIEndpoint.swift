//
//  APIEndpoint.swift
//  CoolPlaces
//
//  Created by Elano Vasconcelos on 29/11/24.
//

import Foundation

enum APIEndpoint {
    case cityProperties(cityID: String)
    case propertyDetail(propertyID: String)
    
    var path: String {
        switch self {
        case .cityProperties(let cityID):
            return "/cities/\(cityID)/properties/"
        case .propertyDetail(let propertyID):
            return "/properties/\(propertyID)"
        }
    }
    var headers: [String: String]? {
        switch self {
        case .cityProperties, .propertyDetail:
            return ["Content-Type": "application/json"]
        }
    }
}
