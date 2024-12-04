//
//  PlacesListViewSnapshotTests.swift
//  CoolPlacesUITests
//
//  Created by Elano Vasconcelos on 02/12/24.
//

import XCTest
import SwiftUI
import SnapshotTesting
@testable import CoolPlaces

final class PlacesListViewSnapshotTests: XCTestCase {

    var viewModel: PlacesListView.ViewModel!
    var mockNetworkService: MockNetworkService!
    var mockRepository: PropertyRepository!
    var mockActionHandler: MockPlacesListActionHandler!
    
    // Sample JSON data filenames
    let successJSONFileName = JSON.cityPropertiesNoImage
    
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

    @MainActor
    func testPlacesListViewSnapshot() async throws {
        // Arrange
        guard let data = loadJSONData(from: successJSONFileName) else {
            XCTFail("Failed to load \(successJSONFileName).json")
            return
        }
        
        let view = PlacesListView(viewModel: viewModel)
            .frame(width: Snapshot.width, height: Snapshot.height)
        
        mockNetworkService.stubbedResult = .success(data)
        
        // Act
        await viewModel.loadItems()
        
        // Assert
        let _ = verifySnapshot(
            of: view,
            as: .wait(for: 0.1, on: .image(
                layout: .fixed(
                    width: Snapshot.width,
                    height: Snapshot.height)
            )),
            record: false
        )
    }

    func testPlacesListViewLoadingSnapshot() {
        // Arrange
        let view = PlacesListView(viewModel: viewModel)
            .frame(width: Snapshot.width, height: Snapshot.height)
        
        // Act & Assert
        assertSnapshot(
            of: view,
            as: .image(layout: .device(config: .iPhoneSe)),
            record: false
        )
    }
}
