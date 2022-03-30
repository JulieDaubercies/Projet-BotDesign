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
    
    private var apiCallsService = APICalls()
    var AlertDelegate: DisplayAlert?
    var items = PublishSubject<[MainData]>()
    let filterModelObservable: Observable<[MainData]>
    var searchValueObserver: AnyObserver<String?> { searchValueBehavior.asObserver() }
    private let searchValueBehavior = BehaviorSubject<String?>(value: "")
    
    // MARK: - init
    
    init() {
        filterModelObservable = Observable.combineLatest(
            searchValueBehavior
                .map { $0 ?? "" }
                .startWith("")
                .throttle(.milliseconds(500), scheduler: MainScheduler.instance),
            items
        )
        .map { searchValue, city in
            searchValue.isEmpty ? city : city.filter { $0.nom.lowercased().contains(searchValue.lowercased()) }
        }
    }
    
    // MARK: - Method
    
    func launchListOfCities() {
        apiCallsService.getCities { [weak self] result in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let list):
                    self?.items.onNext(list)
                    self?.items.onCompleted()
                case .failure(let error):
                    self?.AlertDelegate?.showAlert(message: "\(error)")
                }
            }
        }
    }
}
