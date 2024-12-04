//
//  PropertyRepository.swift
//  CoolPlaces
//
//  Created by Elano Vasconcelos on 29/11/24.
//

import Foundation

protocol PropertyRepository {
    func fetchProperties(for cityID: String) async throws -> [Property]
    func fetchPropertyDetail(propertyID: String) async throws -> Detail
}
