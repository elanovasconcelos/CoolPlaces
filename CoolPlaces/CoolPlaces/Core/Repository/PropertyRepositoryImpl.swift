//
//  PropertyRepositoryImpl.swift
//  CoolPlaces
//
//  Created by Elano Vasconcelos on 29/11/24.
//

import Foundation

final class PropertyRepositoryImpl: PropertyRepository {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchProperties(for cityID: String) async throws -> [Property] {
        let endpoint = APIEndpoint.cityProperties(cityID: cityID)
        let response: PropertiesResponse = try await networkService.fetch(endpoint: endpoint)
        
        return response.properties
    }
    
    func fetchPropertyDetail(propertyID: String) async throws -> Detail {
        let endpoint = APIEndpoint.propertyDetail(propertyID: propertyID)
        let propertyDetail: Detail = try await networkService.fetch(endpoint: endpoint)
        
        return propertyDetail
    }
}
