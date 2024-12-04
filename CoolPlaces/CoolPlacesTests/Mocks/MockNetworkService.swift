//
//  MockNetworkService.swift
//  CoolPlacesTests
//
//  Created by Elano Vasconcelos on 29/11/24.
//

import Foundation
@testable import CoolPlaces

final class MockNetworkService: NetworkServiceProtocol {
    
    var stubbedResult: Result<Data, Error>?
    
    func fetch<T: Codable>(endpoint: APIEndpoint) async throws -> T {
        if let result = stubbedResult {
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(T.self, from: data)
                return decodedData
            case .failure(let error):
                throw error
            }
        } else {
            guard let data = loadJSONData(from: fileName(for: endpoint)) else {
                throw NetworkError.invalidResponse
            }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        }
    }
    
    private func fileName(for endpoint: APIEndpoint) -> String {
        switch endpoint {
        case .cityProperties(_):
            return "CityProperties"
        case .propertyDetail(_):
            return "PropertyDetail"
        }
    }
}
