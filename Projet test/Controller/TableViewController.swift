//
//  TableViewController.swift
//  Projet test
//
//  Created by DAUBERCIES on 24/03/2022.
//

import UIKit
import RxSwift
import RxCocoa


final class TableViewController: UIViewController, Storyboarded {
    
    // MARK: - Properties
    
    private var bag = DisposeBag()
    weak var coordinator: MainCoordinator?
    private let viewModel = ListViewModel()
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var searchBar: UISearchBar!
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Villes de la Haute-Garonne"
        viewModel.AlertDelegate = self
        bindTableData()
        bindToSearchValue()
        searchBar.placeholder = "Toulouse"
    }
    
    func bindToSearchValue() {
        searchBar.rx.text
            .bind(to: viewModel.searchValueObserver)
            .disposed(by: bag)
    }
    
    private func bindTableData() {
        viewModel.filterModelObservable
            .bind(to: tableView
                .rx
                .items(cellIdentifier: "City", cellType: UITableViewCell.self)) { row, model, cell in
                    cell.textLabel?.text = model.nom
                }.disposed(by: bag)
        
        tableView
            .rx
            .modelSelected(MainData.self)
            .subscribe(onNext: {[weak self] city in
                self?.coordinator?.detail(city: city)
            }).disposed(by: bag)
        viewModel.launchListOfCities()
    }
}

extension TableViewController: DisplayAlert {
    func showAlert(message: String) {
        alert(message: message)
    }
}
