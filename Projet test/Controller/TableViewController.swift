//
//  TableViewController.swift
//  Projet test
//
//  Created by DAUBERCIES on 24/03/2022.
//

import UIKit
import RxSwift
import RxCocoa

class TableViewController: UITableViewController {

    let viewModel = ListViewModel()
   // var citiesList = [MainData]()
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = nil
        tableView.delegate = nil
       // viewModel.delegate = self
        bindTableData()
        bindSelection()
    }
    
    func bindTableData() {
        viewModel.items.bind(to: tableView.rx.items(cellIdentifier: "City", cellType: UITableViewCell.self)) { row, model, cell in
            cell.textLabel?.text = model.nom
        }.disposed(by: bag)
        viewModel.launchListOfCities()
    }
    
    func bindSelection() {
        tableView
            .rx
            .modelSelected(MainData.self)
            .subscribe(onNext: {[weak self] city in
                guard let vc = self?.storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController else { return }
                vc.item = city
                self?.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: bag)
            
    }
    
    
//   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//       return citiesList.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "City", for: indexPath)
//        cell.textLabel?.text = citiesList[indexPath.row].nom
//        return cell
//    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
//            let itemPerRow = citiesList
//            vc.item = itemPerRow
//            vc.entityIndexPath = indexPath.row
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//    }
}


//extension TableViewController: CitiesNetworkServiceDelegate {
//    func didCompleteRequest(result: [MainData]) {
//        citiesList = result
//        tableView.reloadData()
//    }
//}


//tableView
//    .rx
//    .modelSelected(MainData.self)
//    .subscribe(onNext: {[weak self] _ in
//        guard let strongSelf = self else { return }
//        guard let vc = strongSelf.storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController else { fatalError("not found") }
//
//        strongSelf.navigationController?.pushViewController(vc, animated: true)
//    }).disposed(by: bag)
