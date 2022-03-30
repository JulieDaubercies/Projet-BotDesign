//
//  MainCoordinator.swift
//  Projet test
//
//  Created by DAUBERCIES on 27/03/2022.
//

import Foundation
import UIKit
import RxSwift

class MainCoordinator: Coordinator {
    
    // MARK: - Properties
    
   // var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    
    func start() -> Observable<Void> {
        let vc = TableViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
        return .never()
    }
    
    func detail(city: MainData) {
        let vc = DetailViewController.instantiate()
        vc.coordinator = self
        vc.item = city
        navigationController.pushViewController(vc, animated: true)
    }
}
