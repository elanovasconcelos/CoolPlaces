//
//  DetailItem.swift
//  CoolPlaces
//
//  Created by Elano Vasconcelos on 30/11/24.
//

import Foundation

struct DetailItem {
    let name: String
    let address: String
    let city: String
    let country: String
    let propertyDescription: String
    let propertyDirections: String
    let imageUrl: String?
}

extension DetailItem {
    init(_ detail: Detail) {
        self.name = detail.name
        self.city = detail.city?.name ?? ""
        self.country = detail.city?.country ?? ""
        self.propertyDescription = detail.description ?? ""
        self.propertyDirections = detail.directions ?? ""
        
        if let address2 = detail.address2, address2.isEmpty {
            self.address = detail.address1 ?? ""
        } else {
            self.address = "\(detail.address1 ?? "")\n\(detail.address2 ?? "")"
        }
        
        if let firstImage = detail.images?.first {
            //TODO: Adding an 's' or an 'l' is not working for me
            self.imageUrl = "\(firstImage.prefix.replacingOccurrences(of: "http", with: "https"))\(firstImage.suffix)"
        } else {
            self.imageUrl = nil
        }
    }
}
