//
//  ViewController.swift
//  Projet test
//
//  Created by DAUBERCIES on 24/03/2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var postalCodeLabel: UILabel!
    @IBOutlet var populationLabel: UILabel!
    @IBOutlet var surfaceLabel: UILabel!
    var viewModel = DetailViewModel()
    var item = [MainData]()
    var entityIndexPath: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.item = item
        viewModel.entityIndexPath = entityIndexPath
        viewModel.loadCityData()
        
        viewModel.cityName.bind { [weak self] city in
            self?.cityNameLabel.text = city
        }
        viewModel.postalCode.bind { [weak self] postal in
            self?.postalCodeLabel.text = postal
        }
        viewModel.population.bind { [weak self] people in
            self?.populationLabel.text = people
        }
        viewModel.surface.bind { [weak self] sizeSurface in
            self?.surfaceLabel.text = sizeSurface
        }
    }


}

