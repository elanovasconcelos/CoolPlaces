//
//  PlacesListView.swift
//  CoolPlaces
//
//  Created by Elano Vasconcelos on 29/11/24.
//

import SwiftUI

struct PlacesListView: View {

    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            List(viewModel.items) { item in
                Button {
                    viewModel.didSelect(item)
                } label: {
                    PlaceItemView(item: item)
                }
                .accessibilityIdentifier("PlaceItemView_\(item.id)")
            }
            .accessibilityIdentifier("PlacesListView_List")
            
            if viewModel.items.isEmpty {
                ProgressView()
                    .accessibilityIdentifier("PlacesListView_LoadingIndicator")
            }
        }
        .task {
            await viewModel.loadItems()
        }
    }
}

extension PlacesListView {
    enum Action {
        case didSelect(PlaceItem)
        case showError(String)
    }
    
    final class ViewModel: ObservableObject {
        
        @Published var items = [PlaceItem]()
        
        private let cityID: String
        private let repository: PropertyRepository
        private let onActionSelected: (PlacesListView.Action) -> Void
        
        init(cityID: String = "1530",
             repository: PropertyRepository = PropertyRepositoryImpl(),
             onActionSelected: @escaping (PlacesListView.Action) -> Void = {_ in }) {
            self.cityID = cityID
            self.repository = repository
            self.onActionSelected = onActionSelected
        }
        
        func didSelect(_ property: PlaceItem) {
            onActionSelected(.didSelect(property))
        }
        
        @MainActor
        func loadItems() async {
            do {
                items = try await repository.fetchProperties(for: cityID).map{ .init($0) }
            } catch {
                onActionSelected(.showError(error.localizedDescription))
            }
        }
    }
}

#Preview {
    PlacesListView(viewModel: PlacesListView.ViewModel())
}
