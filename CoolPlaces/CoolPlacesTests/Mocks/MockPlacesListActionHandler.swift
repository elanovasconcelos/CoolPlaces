//
//  MockPlacesListActionHandler.swift
//  CoolPlacesTests
//
//  Created by Elano Vasconcelos on 01/12/24.
//

import Foundation
@testable import CoolPlaces

final class MockPlacesListActionHandler {
    var didSelectItem: PlaceItem?
    var showErrorMessage: String?

    func handleAction(_ action: PlacesListView.Action) {
        switch action {
        case .didSelect(let item):
            didSelectItem = item
        case .showError(let message):
            showErrorMessage = message
        }
    }
}
