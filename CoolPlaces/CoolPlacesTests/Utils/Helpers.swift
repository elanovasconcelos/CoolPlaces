//
//  Helpers.swift
//  CoolPlacesTests
//
//  Created by Elano Vasconcelos on 01/12/24.
//

import Foundation

func loadJSONData(from fileName: String) -> Data? {
    let bundle = Bundle(for: MockNetworkService.self)
    guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
        print("Erro loading \(fileName).json")
        return nil
    }
    
    do {
        let data = try Data(contentsOf: url)
        return data
    } catch {
        print("Error with file \(fileName).json: \(error)")
        return nil
    }
}

struct JSON {
    static let cityProperties = "CityProperties"
    static let cityPropertiesNoImage = "CityPropertiesNoImage"
    static let propertyDetail = "PropertyDetail"
    static let propertyDetailNoImage = "PropertyDetailNoImage"
    static let invalid = "InvalidResponse"
}

struct Snapshot {
    static let width: CGFloat = 375
    static let height: CGFloat = 1000
}
