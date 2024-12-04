//
//  PlacesListViewModelTests.swift
//  CoolPlacesTests
//
//  Created by Elano Vasconcelos on 01/12/24.
//

import XCTest
@testable import CoolPlaces

final class PlacesListViewModelTests: XCTestCase {

    var viewModel: PlacesListView.ViewModel!
    var mockNetworkService: MockNetworkService!
    var mockRepository: PropertyRepository!
    var mockActionHandler: MockPlacesListActionHandler!
    
    // Sample JSON data filenames
    let successJSONFileName = JSON.cityProperties
    let failureJSONFileName = JSON.invalid
    
    override func setUpWithError() throws {
        mockNetworkService = MockNetworkService()
        mockRepository = PropertyRepositoryImpl(networkService: mockNetworkService)
        mockActionHandler = MockPlacesListActionHandler()
        
        viewModel = PlacesListView.ViewModel(
            cityID: "1530",
            repository: mockRepository,
            onActionSelected: mockActionHandler.handleAction
        )
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockRepository = nil
        mockNetworkService = nil
        mockActionHandler = nil
    }

    /// Tests that the ViewModel successfully loads items when the repository fetch is successful
    func testLoadItemsSuccess() async throws {
        // Arrange
        guard let data = loadJSONData(from: successJSONFileName) else {
            XCTFail("Failed to load \(successJSONFileName).json")
            return
        }
        
        mockNetworkService.stubbedResult = .success(data)
        
        // Act
        await viewModel.loadItems()
        
        // Assert
        XCTAssertEqual(viewModel.items.count, 2)
        
        if let firstItem = viewModel.items.first {
            XCTAssertEqual(firstItem.id, "32849")
            XCTAssertEqual(firstItem.name, "STF Vandrarhem Stigbergsliden")
            XCTAssertEqual(firstItem.cityName, "Gothenburg")
            XCTAssertEqual(firstItem.type, "HOSTEL")
            XCTAssertEqual(firstItem.rating, "82%")
            XCTAssertEqual(firstItem.thumbnail, "https://ucd.hwstatic.com/propertyimages/3/32849/7.jpg")
        }
        
        XCTAssertNil(mockActionHandler.showErrorMessage, "No error message should be shown on successful load.")
    }
    
    /// Tests that the ViewModel handles errors appropriately when the repository fetch fails
    func testLoadItemsFailure() async throws {
        // Arrange
        mockNetworkService.stubbedResult = .failure(NetworkError.invalidResponse)
        
        // Act
        await viewModel.loadItems()
        
        // Assert
        XCTAssertTrue(viewModel.items.isEmpty)
        XCTAssertEqual(mockActionHandler.showErrorMessage, NetworkError.invalidResponse.localizedDescription)
    }

    /// Tests that selecting an item triggers the appropriate action
    func testDidSelect() async throws {
        // Arrange
        guard let data = loadJSONData(from: successJSONFileName) else {
            XCTFail("Failed to load \(successJSONFileName).json")
            return
        }
        
        mockNetworkService.stubbedResult = .success(data)
        
        // Act
        await viewModel.loadItems()
        guard let item = viewModel.items.first else {
            XCTFail("No item")
            return
        }
        viewModel.didSelect(item)
        
        // Assert
        XCTAssertEqual(mockActionHandler.didSelectItem?.id, item.id)
    }
}
