//
//  Coordinator.swift
//  CoolPlaces
//
//  Created by Elano Vasconcelos on 29/11/24.
//

import UIKit

/// Base protocol for Coordinators
protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    /// Start the coordinator
    func start()
}
