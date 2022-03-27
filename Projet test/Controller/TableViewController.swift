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
    
    private let viewModel = ListViewModel()
    let detailViewModel = DetailViewModel()
    private var bag = DisposeBag()
    weak var coordinator: MainCoordinator?
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = nil
        tableView.delegate = nil
        bindTableData()
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
                self?.coordinator?.detail()
                
                // Comment transmettre les données ???
                
                
            }).disposed(by: bag)
        viewModel.launchListOfCities()
    }
}

//  guard let vc = self?.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
//  vc.item = city
//  self?.navigationController?.pushViewController(vc, animated: true)
