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
    
    private let disposeBag = DisposeBag()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods

//     Ancienne version
//    func start() -> Observable<Void> {
//        let vc = TableViewController.instantiate()
//        vc.coordinator = self
//        navigationController.pushViewController(vc, animated: false)
//        return .never()
//    }
    
    func start() -> Observable<Void> {
        let vc = TableViewController.instantiate()
        let viewModel = ListViewModel()
        vc.viewModel = viewModel
        
        viewModel.citySelected
            .subscribe(onNext: { [weak self] city in
                self?.detail(city: city)
            })
            .disposed(by: disposeBag)

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
