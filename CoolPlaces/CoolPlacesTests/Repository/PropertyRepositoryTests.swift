//
//  PropertyRepositoryTests.swift
//  CoolPlacesTests
//
//  Created by Elano Vasconcelos on 29/11/24.
//

import XCTest
@testable import CoolPlaces

final class PropertyRepositoryTests: XCTestCase {

    var repository: PropertyRepositoryImpl!
    var mockNetworkService: MockNetworkService!
    
    override func setUpWithError() throws {
        mockNetworkService = MockNetworkService()
        repository = PropertyRepositoryImpl(networkService: mockNetworkService)
    }

    override func tearDownWithError() throws {
        repository = nil
        mockNetworkService = nil
    }

    func testFetchPropertiesSuccess() async throws {
        // Arrange
        // JSON "CityProperties.json"
        
        // Act
        let properties = try await repository.fetchProperties(for: "0")
        
        // Assert
        XCTAssertEqual(properties.count, 2)
        
        if !properties.isEmpty {
            XCTAssertEqual(properties[0].id, "32849")
            XCTAssertEqual(properties[0].name, "STF Vandrarhem Stigbergsliden")
            XCTAssertEqual(properties[0].city.name, "Gothenburg")
            XCTAssertEqual(properties[0].images.first?.prefix, "http://ucd.hwstatic.com/propertyimages/3/32849/7")
            XCTAssertEqual(properties[0].images.first?.suffix, ".jpg")
            XCTAssertEqual(properties[0].overallRating.numberOfRatings, 400)
        }
    }
    
    func testFetchPropertiesFailure() async {
        // Arrange
        mockNetworkService.stubbedResult = .failure(NetworkError.invalidResponse)
        
        // Act & Assert
        do {
            let _: [Property] = try await repository.fetchProperties(for: "1")
            XCTFail("Expected to throw NetworkError.invalidResponse, but no error was thrown.")
        } catch {
            XCTAssertEqual(error.localizedDescription, NetworkError.invalidResponse.localizedDescription)
        } 
    }
    
    func testFetchPropertyDetailSuccess() async throws {
        // Arrange
        // JSON "PropertyDetail.json"
        
        // Act
        let propertyDetail: Detail = try await repository.fetchPropertyDetail(propertyID: "2")
        
        // Assert
        XCTAssertEqual(propertyDetail.id, "32849")
        XCTAssertEqual(propertyDetail.name, "STF Vandrarhem Stigbergsliden")
        XCTAssertEqual(propertyDetail.description, "Set in a listed building...")
        XCTAssertEqual(propertyDetail.rating?.atmosphere, 71)
        XCTAssertEqual(propertyDetail.city?.name, "Gothenburg")
        XCTAssertEqual(propertyDetail.images?.first?.prefix, "http://ucd.hwstatic.com/propertyimages/3/32849/7")
        XCTAssertEqual(propertyDetail.images?.first?.suffix, ".jpg")
    }
    
    func testFetchPropertyDetailFailure() async {
        // Arrange
        mockNetworkService.stubbedResult = .failure(NetworkError.decodingFailed(NSError(domain: "", code: -1, userInfo: nil)))
        
        // Act & Assert
        do {
            let _: Detail = try await repository.fetchPropertyDetail(propertyID: "1")
            XCTFail("Expected to throw NetworkError.decodingFailed, but no error was thrown.")
        } catch let error as NetworkError {
            switch error {
            case .decodingFailed:
                XCTAssertTrue(true)
            default:
                XCTFail("Expected NetworkError.decodingFailed, but received: \(error)")
            }
        } catch {
            XCTFail("Expected NetworkError.decodingFailed, but received different error: \(error)")
        }
    }
}
