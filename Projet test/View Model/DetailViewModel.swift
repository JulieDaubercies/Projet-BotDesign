//
//  DetailViewModel.swift
//  Projet test
//
//  Created by DAUBERCIES on 25/03/2022.
//

import Foundation

class DetailViewModel {
    
    var item = [MainData]()
    var entityIndexPath: Int!
    var cityName: Box<String> = Box("")
    var postalCode: Box<String> = Box("")
    var population: Box<String> = Box("")
    var surface: Box<String> = Box("")
    
    func loadCityData() {
        let postalCodeList = item[entityIndexPath].codesPostaux.joined(separator: "\n")
        
        cityName.value = item[entityIndexPath].nom.uppercased()
        + "\n"
        + "\nHaute-Garonne"
        + "\nOccitanie"
        
        if item[entityIndexPath].codesPostaux.count == 1 {
            postalCode.value = "Code Postal: "
            + "\n\(item[entityIndexPath].codesPostaux[0])"
        } else {
            postalCode.value = "Codes Postaux: "
            + "\n\(postalCodeList)"
        }
       
        population.value = "Population: " + String(item[entityIndexPath].population) + " Habitants"
        surface.value = "Surface: " + String(item[entityIndexPath].surface) + " m²"
    }
    
}
