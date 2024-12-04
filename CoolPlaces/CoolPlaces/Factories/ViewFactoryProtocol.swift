//
//  ViewFactoryProtocol.swift
//  CoolPlaces
//
//  Created by Elano Vasconcelos on 29/11/24.
//

import Foundation

protocol ViewFactoryProtocol {
    
    /// Creates the Places List View with a closure for place selection
    func makePlacesListView(onActionSelected: @escaping (PlacesListView.Action) -> Void) -> PlacesListView
    
    /// Creates the Place Detail View
    func makePlaceDetailView(propertyID: String, onActionSelected: @escaping (PlaceDetailView.Action) -> Void) -> PlaceDetailView
}
