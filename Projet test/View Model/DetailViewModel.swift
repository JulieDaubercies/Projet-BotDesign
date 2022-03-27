//
//  DetailViewModel.swift
//  Projet test
//
//  Created by DAUBERCIES on 25/03/2022.
//

import Foundation

final class DetailViewModel {
    
    // MARK: - Properties
    
    var item: MainData?
    var cityName: Box<String> = Box("")
    var postalCode: Box<String> = Box("")
    var population: Box<String> = Box("")
    var surface: Box<String> = Box("")
    
    // MARK: - Method
    
    func loadCityData() {
        guard let city = item else { return }
        let postalCodeList = city.codesPostaux.joined(separator: "\n")
        cityName.value = city.nom.uppercased()
        + "\n"
        + "\nHaute-Garonne"
        + "\nOccitanie"
        
        if city.codesPostaux.count == 1 {
            postalCode.value = "Code Postal: "
            + "\n\(city.codesPostaux[0])"
        } else {
            postalCode.value = "Codes Postaux: "
            + "\n\(postalCodeList)"
        }
        population.value = "Population: " + String(city.population) + " Habitants"
        surface.value = "Surface: " + String(city.surface) + " m²"
    }
}
