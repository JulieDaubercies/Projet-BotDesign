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
    
    let displayModelObservable: Observable<[MainData]>
    var searchValueObserver: AnyObserver<String?> { searchValueBehavior.asObserver() }
    private let searchValueBehavior = BehaviorSubject<String?>(value: "")
    
    var citySelected = PublishSubject<MainData>()
    
    // MARK: - init
    
    init() {
        let items = PublishSubject<[MainData]>()
        
        displayModelObservable = Observable.combineLatest(
            searchValueBehavior
                .map { $0 ?? "" }
                .startWith("")
                .throttle(.milliseconds(500), scheduler: MainScheduler.instance),
            items
        )
        .map { searchValue, city in
            searchValue.isEmpty ? city : city.filter { $0.nom.lowercased().contains(searchValue.lowercased()) }
        }
        
        apiCallsService.getCities { [weak self] result in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let list):
                    items.onNext(list)
                    items.onCompleted()
                case .failure(let error):
                    self?.AlertDelegate?.showAlert(message: "\(error)")
                }
            }
        }
    }
}
