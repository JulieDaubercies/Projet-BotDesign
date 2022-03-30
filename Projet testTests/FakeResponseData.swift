//
//  FakeResponseData.swift
//  Projet testTests
//
//  Created by DAUBERCIES on 30/03/2022.
//

import Foundation
import Projet_test

class FakeResponseData {

    static let urlApi: URL = URL(string: "https://geo.api.gouv.fr/departements/31/communes?fields=nom,codesPostaux,surface,population&format=json&geometry=centre")!
    
    static let responseOK = HTTPURLResponse(url: URL(string: "http://data")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "http://data")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    class NetworkError: Error {}
    static let error = NetworkError()

    static var correctData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Villes", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    static let incorrectData = "erreur".data(using: .utf8)
}
