//
//  PlaceItem.swift
//  CoolPlaces
//
//  Created by Elano Vasconcelos on 30/11/24.
//

import Foundation

struct PlaceItem: Identifiable {
    let id: String
    let name: String
    let type: String
    let cityName: String
    let rating: String
    let thumbnail: String?
}

extension PlaceItem {
    
    init(_ property: Property) {
        self.id = property.id
        self.name = property.name
        self.type = property.type
        self.cityName = property.city.name
        self.rating = "\(property.overallRating.overall ?? 0)%"
        
        if let firstImage = property.images.first {
            //TODO: Adding an 's' or an 'l' is not working for me
            self.thumbnail = "\(firstImage.prefix.replacingOccurrences(of: "http", with: "https"))\(firstImage.suffix)"
        } else {
            self.thumbnail = nil
        }
    }
    
    static var debug: PlaceItem {
        PlaceItem(
            id: "1",
            name: "Property name",
            type: "HOTEL", 
            cityName: "City name",
            rating: "90%",
            thumbnail: "https://ucd.hwstatic.com/propertyimages/3/32849/7.jpg"
        )
    }
    
    static var debugNoImage: PlaceItem {
        PlaceItem(
            id: "1",
            name: "Property name",
            type: "HOTEL",
            cityName: "City name",
            rating: "90",
            thumbnail: nil
        )
    }
}
