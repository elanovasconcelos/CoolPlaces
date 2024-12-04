//
//  DetailView.swift
//  CoolPlaces
//
//  Created by Elano Vasconcelos on 29/11/24.
//

import SwiftUI

struct PlaceDetailView: View {

    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            if let detail = viewModel.detail {
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ImageView(url: detail.imageUrl)
                            .aspectRatio(contentMode: .fit)
                            .accessibilityIdentifier("ImageView")
                        
                        ForEach(viewModel.textItems) { item in
                            TextView(title: item.title, detail: item.detail)
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                                .accessibilityIdentifier("PlaceDetail_\(item.title)")
                        }
                    }
                }
                
            } else {
                ProgressView()
                    .accessibilityIdentifier("PlaceDetailLoadingIndicator")
            }
        }
        .task {
            await viewModel.loadDetails()
        }
    }
}

extension PlaceDetailView {
    enum Action {
        case showError(String)
    }
    
    final class ViewModel: ObservableObject {
        
        @Published var detail: DetailItem?
        @Published var textItems = [TextItem]()
        
        private let propertyID: String
        private let repository: PropertyRepository
        private let onActionSelected: (PlaceDetailView.Action) -> Void
        
        init(propertyID: String,
             repository: PropertyRepository = PropertyRepositoryImpl(),
             onActionSelected: @escaping (PlaceDetailView.Action) -> Void = {_ in }) {
            self.propertyID = propertyID
            self.repository = repository
            self.onActionSelected = onActionSelected
        }
        
        @MainActor
        func loadDetails() async {
            do {
                let newDetail = try await repository.fetchPropertyDetail(propertyID: propertyID)
                let newDetailItem = DetailItem(newDetail)
                
                detail = newDetailItem
                textItems = makeTextItem(detail: newDetailItem)
            } catch {
                onActionSelected(.showError(error.localizedDescription))
            }
        }
        
        private func makeTextItem(detail: DetailItem) -> [TextItem] {
            [
                TextItem(title: "Address", detail: detail.address),
                TextItem(title: "City", detail: detail.city),
                TextItem(title: "Country", detail: detail.country),
                TextItem(title: "Description", detail: detail.propertyDescription),
                TextItem(title: "Directions", detail: detail.propertyDirections)
            ]
        }
    }
}

#Preview {
    PlaceDetailView(viewModel: PlaceDetailView.ViewModel(propertyID: "32849"))
}


