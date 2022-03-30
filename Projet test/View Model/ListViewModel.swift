//
//  ListViewModel.swift
//  Projet test
//
//  Created by DAUBERCIES on 24/03/2022.
//

import Foundation
import RxSwift
import RxRelay
//import RxCocoa

protocol DisplayAlert: AnyObject {
    func showAlert(message: String)
}

final class ListViewModel {
    
    // MARK: - Properties
    
    var items = PublishSubject<[MainData]>()
    // var item = PublishRelay <MainData>()
    
    private var apiCallsService = APICalls()
    var AlertDelegate: DisplayAlert?
    
    // MARK: - Method
    
    func launchListOfCities() {
        apiCallsService.getCities { [weak self] result in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let list):
                    let products = list
                    self?.items.onNext(products)
                    self?.items.onCompleted()
                case .failure(let error):
                    print(error)
                    self?.AlertDelegate?.showAlert(message: "\(error)")
                }
            }
        }
    }
}
