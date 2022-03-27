//
//  Coordinator.swift
//  Projet test
//
//  Created by DAUBERCIES on 27/03/2022.
//

import Foundation
import UIKit

protocol Coordinator {
    
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
