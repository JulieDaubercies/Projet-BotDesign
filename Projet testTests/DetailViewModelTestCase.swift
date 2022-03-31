//
//  DetailViewModelTestCase.swift
//  Projet testTests
//
//  Created by DAUBERCIES on 30/03/2022.
//

import XCTest
@testable import Projet_test

class DetailViewModelTestCase: XCTestCase {

    var viewModel: DetailViewModel!
    var item: MainData = MainData(nom: "Toulouse", codesPostaux: ["13100"], surface: 20.00, population: 12, code: "")
    
    override func setUp(){
        super.setUp()
        viewModel = DetailViewModel()
    }
    
    func test_When_Then() {
        viewModel.item = item
        viewModel.loadCityData()
        
        XCTAssertEqual(viewModel.cityName.value, "TOULOUSE"
                       + "\n"
                       + "\nHaute-Garonne"
                       + "\nOccitanie")
    }

}
