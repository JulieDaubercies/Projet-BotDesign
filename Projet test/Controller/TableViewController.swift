//
//  TableViewController.swift
//  Projet test
//
//  Created by DAUBERCIES on 24/03/2022.
//

import UIKit
import RxSwift
import RxCocoa


final class TableViewController: UITableViewController, Storyboarded {
    
    // MARK: - Properties
    
    private var bag = DisposeBag()
    weak var coordinator: MainCoordinator?
    private let viewModel = ListViewModel()
    private let searchController = UISearchController(searchResultsController: nil)
//    private var isSearchBarEmpty: Bool { return searchController.searchBar.text?.isEmpty ?? true }
//    private var isFiltering: Bool {
//        return !isSearchBarEmpty
//    }
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = nil
        tableView.delegate = nil
        bindTableData()
        searchBarSettings()
    }
    
    func searchBarSettings() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Toulouse"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func bindTableData() {
        viewModel.items.bind(to: tableView
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

extension TableViewController: UISearchResultsUpdating  {
    
    func updateSearchResults(for searchController: UISearchController) {
     let essai = searchController.searchBar.rx.text.orEmpty
            .throttle(.microseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map { query in
                self.viewModel.items.filter { city in
                    city.map { $0.nom }.contains(query.lowercased())
                }
            }
        tableView.reloadData()
    }
}
