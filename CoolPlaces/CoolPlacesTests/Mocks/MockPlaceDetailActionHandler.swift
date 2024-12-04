//
//  MockPlaceDetailActionHandler.swift
//  CoolPlacesTests
//
//  Created by Elano Vasconcelos on 01/12/24.
//

import Foundation
@testable import CoolPlaces

final class MockPlaceDetailActionHandler {
    var showErrorMessage: String?
    
    func handleAction(_ action: PlaceDetailView.Action) {
        switch action {
        case .showError(let message):
            showErrorMessage = message
        }
    }
}
