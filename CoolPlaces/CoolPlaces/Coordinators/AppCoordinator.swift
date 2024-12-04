//
//  AppCoordinator.swift
//  CoolPlaces
//
//  Created by Elano Vasconcelos on 29/11/24.
//

import UIKit
import SwiftUI

final class AppCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    private let viewFactory: ViewFactoryProtocol

    init(navigationController: UINavigationController, 
         viewFactory: ViewFactoryProtocol = ViewFactory()) {
        self.navigationController = navigationController
        self.viewFactory = viewFactory
    }

    /// Starts the coordinator by displaying the Places List
    func start() {
        let placesListView = viewFactory.makePlacesListView { [weak self] action in
            switch action {
            case .didSelect(let item):
                self?.showPlaceDetail(item: item)
            case .showError(let message):
                self?.showError(message: message)
            }
        }
        
        let hostingController = UIHostingController(rootView: placesListView)
        hostingController.title = "Places"
        
        navigationController.pushViewController(hostingController, animated: false)
    }
    
    /// Navigate to Place Detail
    func showPlaceDetail(item: PlaceItem) {
        let detailView = viewFactory.makePlaceDetailView(propertyID: item.id) { [weak self] action in
            switch action {
            case .showError(let message):
                self?.showError(message: message)
            }
        }
        
        let hostingController = UIHostingController(rootView: detailView)
        hostingController.title = item.name
        
        navigationController.pushViewController(hostingController, animated: true)
    }
    
    func showError(message: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            guard let topViewController = self.navigationController.topViewController else { return }
            
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            topViewController.present(alert, animated: true, completion: nil)
        }
    }
}

