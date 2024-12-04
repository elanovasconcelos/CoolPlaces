//
//  ViewFactory.swift
//  CoolPlaces
//
//  Created by Elano Vasconcelos on 29/11/24.
//

import Foundation

final class ViewFactory: ViewFactoryProtocol {

    private let repository: PropertyRepository
    
    init(repository: PropertyRepository = PropertyRepositoryImpl()) {
        self.repository = repository
    }
    
    func makePlacesListView(onActionSelected: @escaping (PlacesListView.Action) -> Void) -> PlacesListView {
        let viewModel = PlacesListView.ViewModel(
            repository: repository,
            onActionSelected: onActionSelected
        )
        
        return PlacesListView(viewModel: viewModel)
    }
    
    func makePlaceDetailView(propertyID: String, onActionSelected: @escaping (PlaceDetailView.Action) -> Void) -> PlaceDetailView {
        let viewModel = PlaceDetailView.ViewModel(
            propertyID: propertyID,
            repository: repository,
            onActionSelected: onActionSelected
        )
        
        return PlaceDetailView(viewModel: viewModel)
    }
}
