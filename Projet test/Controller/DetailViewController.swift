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
    var item = [MainData]()
    var entityIndexPath: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let postalCodeList = item[entityIndexPath].codesPostaux.joined(separator: "\n")
        
        cityNameLabel.text = item[entityIndexPath].nom.uppercased()
        + "\n"
        + "\nHaute-Garonne"
        + "\nOccitanie"
        
        if item[entityIndexPath].codesPostaux.count == 1 {
            postalCodeLabel.text = "Code Postal: "
            + "\n\(item[entityIndexPath].codesPostaux[0])"
        } else {
            postalCodeLabel.text = "Codes Postaux: "
            + "\n\(postalCodeList)"
        }
       
        populationLabel.text = "Population: " + String(item[entityIndexPath].population) + " Habitants"
        surfaceLabel.text = "Surface: " + String(item[entityIndexPath].surface) + " m²"
    }


}

