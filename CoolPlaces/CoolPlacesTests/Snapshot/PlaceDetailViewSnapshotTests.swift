//
//  PlaceDetailViewSnapshotTests.swift
//  CoolPlacesTests
//
//  Created by Elano Vasconcelos on 02/12/24.
//

import XCTest
import SwiftUI
import SnapshotTesting
@testable import CoolPlaces

final class PlaceDetailViewSnapshotTests: XCTestCase {

    var viewModel: PlaceDetailView.ViewModel!
    var mockNetworkService: MockNetworkService!
    var mockRepository: PropertyRepository!
    var mockActionHandler: MockPlaceDetailActionHandler!
    
    // Sample JSON data filenames
    let successJSONFileName = JSON.propertyDetailNoImage
    
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

    @MainActor
    func testPlaceDetailViewSnapshotSuccess() async throws {
        // Arrange
        guard let data = loadJSONData(from: successJSONFileName) else {
            XCTFail("Failed to load \(successJSONFileName).json")
            return
        }

        let view = PlaceDetailView(viewModel: viewModel)
        
        mockNetworkService.stubbedResult = .success(data)
        
        // Act
        await viewModel.loadDetails()
        
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

    func testPlaceDetailViewSnapshotLoading() throws {
        // Arrange
        let view = PlaceDetailView(viewModel: viewModel)
        
        // Act & Assert
        assertSnapshot(
            of: view,
            as: .image(layout: .device(config: .iPhoneSe)),
            record: false
        )
    }

}
