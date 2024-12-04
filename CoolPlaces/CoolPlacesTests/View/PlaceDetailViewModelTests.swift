//
//  PlaceDetailViewModelTests.swift
//  CoolPlacesTests
//
//  Created by Elano Vasconcelos on 01/12/24.
//

import XCTest
@testable import CoolPlaces

final class PlaceDetailViewModelTests: XCTestCase {

    var viewModel: PlaceDetailView.ViewModel!
    var mockNetworkService: MockNetworkService!
    var mockRepository: PropertyRepository!
    var mockActionHandler: MockPlaceDetailActionHandler!
    
    // Sample JSON data filenames
    let successJSONFileName = JSON.propertyDetail
    let failureJSONFileName = JSON.invalid
    
    override func setUpWithError() throws {
        mockNetworkService = MockNetworkService()
        mockRepository = PropertyRepositoryImpl(networkService: mockNetworkService)
        mockActionHandler = MockPlaceDetailActionHandler()
        
        viewModel = PlaceDetailView.ViewModel(
            propertyID: "1",
            repository: mockRepository,
            onActionSelected: mockActionHandler.handleAction
        )
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockNetworkService = nil
        mockRepository = nil
        mockActionHandler = nil
    }

    /// Tests that the ViewModel successfully loads details when the repository fetch is successful
    func testLoadDetailsSuccess() async throws {
        // Arrange
        guard let data = loadJSONData(from: successJSONFileName) else {
            XCTFail("Failed to load \(successJSONFileName).json")
            return
        }

        mockNetworkService.stubbedResult = .success(data)
        
        // Act
        await viewModel.loadDetails()
        
        // Assert
        XCTAssertNotNil(viewModel.detail)
        XCTAssertEqual(viewModel.detail?.address, "Stigbergsliden 10")
        XCTAssertEqual(viewModel.detail?.city, "Gothenburg")
        XCTAssertEqual(viewModel.detail?.country, "Sweden")
        XCTAssertEqual(viewModel.detail?.propertyDescription, "Set in a listed building...")
        XCTAssertEqual(viewModel.detail?.propertyDirections, "Public transportation: Take the tram number 3, ...")
        
        // Verify that textItems are correctly created
        XCTAssertEqual(viewModel.textItems.count, 5)
        if !viewModel.textItems.isEmpty {
            XCTAssertEqual(viewModel.textItems[0].title, "Address")
            XCTAssertEqual(viewModel.textItems[0].detail, "Stigbergsliden 10")
        }
        
        // Ensure no error was emitted
        XCTAssertNil(mockActionHandler.showErrorMessage)
    }

    /// Tests that the ViewModel handles errors appropriately when the repository fetch fails
    func testLoadDetailsFailure() async throws {
        // Arrange
        mockNetworkService.stubbedResult = .failure(NetworkError.invalidResponse)
        
        // Act
        await viewModel.loadDetails()
        
        // Assert
        XCTAssertNil(viewModel.detail)
        XCTAssertTrue(viewModel.textItems.isEmpty)
        XCTAssertEqual(mockActionHandler.showErrorMessage, NetworkError.invalidResponse.localizedDescription)
    }
}
