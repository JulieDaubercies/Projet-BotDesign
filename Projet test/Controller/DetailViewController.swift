//
//  ViewController.swift
//  Projet test
//
//  Created by DAUBERCIES on 24/03/2022.
//

import UIKit

class DetailViewController: UIViewController, Storyboarded {
    
    // MARK: - Properties
    
    @IBOutlet private var cityNameLabel: UILabel!
    @IBOutlet private var postalCodeLabel: UILabel!
    @IBOutlet private var populationLabel: UILabel!
    @IBOutlet private var surfaceLabel: UILabel!
    private var viewModel = DetailViewModel()
    var item: MainData?
    var coordinator: MainCoordinator?
    
    // MARK: - Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.item = item
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
