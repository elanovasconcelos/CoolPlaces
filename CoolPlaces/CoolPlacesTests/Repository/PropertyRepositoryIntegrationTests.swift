//
//  PropertyRepositoryIntegrationTests.swift
//  CoolPlacesTests
//
//  Created by Elano Vasconcelos on 29/11/24.
//

import XCTest
@testable import CoolPlaces

final class PropertyRepositoryIntegrationTests: XCTestCase {

    var repository: PropertyRepositoryImpl!
    var networkService: NetworkService!
    
    override func setUpWithError() throws {
        networkService = NetworkService()
        repository = PropertyRepositoryImpl(networkService: networkService)
    }

    override func tearDownWithError() throws {
        repository = nil
        networkService = nil
    }

    func testFetchPropertiesFromAPI() async throws {
        // Arrange
        let cityID = "1530"
        
        // Act
        let properties: [Property] = try await repository.fetchProperties(for: cityID)
        
        // Assert
        XCTAssertEqual(properties.count, 19)
        
        if !properties.isEmpty {
            XCTAssertEqual(properties[0].id, "32849")
            XCTAssertEqual(properties[0].name, "STF Vandrarhem Stigbergsliden")
            XCTAssertEqual(properties[0].city.name, "Gothenburg")
            XCTAssertEqual(properties[0].images.first?.prefix, "http://ucd.hwstatic.com/propertyimages/3/32849/7")
            XCTAssertEqual(properties[0].images.first?.suffix, ".jpg")
            XCTAssertEqual(properties[0].overallRating.numberOfRatings, 400)
        }
    }
    
    func testFetchPropertyDetailFromAPI() async throws {
        // Arrange
        let propertyID = "32849"
        
        // Act
        let propertyDetail: Detail = try await repository.fetchPropertyDetail(propertyID: propertyID)
        
        // Assert
        XCTAssertEqual(propertyDetail.id, "\(propertyID)")
        XCTAssertEqual(propertyDetail.name, "STF Vandrarhem Stigbergsliden")
        XCTAssertEqual(propertyDetail.rating?.atmosphere, 71)
        XCTAssertEqual(propertyDetail.city?.name, "Gothenburg")
        XCTAssertEqual(propertyDetail.images?.first?.prefix, "http://ucd.hwstatic.com/propertyimages/3/32849/7")
        XCTAssertEqual(propertyDetail.images?.first?.suffix, ".jpg")
    }
}
