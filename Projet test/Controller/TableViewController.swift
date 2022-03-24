//
//  TableViewController.swift
//  Projet test
//
//  Created by DAUBERCIES on 24/03/2022.
//

import UIKit

class TableViewController: UITableViewController {

    let viewModel = ListViewModel()
    var citiesList = [MainData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.launchListOfCities()
    }
    
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return citiesList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "City", for: indexPath)
        cell.textLabel?.text = citiesList[indexPath.row].nom
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            let itemPerRow = citiesList
            vc.item = itemPerRow
            vc.entityIndexPath = indexPath.row
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


extension TableViewController: CitiesNetworkServiceDelegate {
    func didCompleteRequest(result: [MainData]) {
        citiesList = result
        tableView.reloadData()
    }
    
    
}
