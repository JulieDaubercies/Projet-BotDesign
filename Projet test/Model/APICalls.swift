//
//  APICalls.swift
//  Projet test
//
//  Created by DAUBERCIES on 24/03/2022.
//

import Foundation

final class APICalls {
    
    // MARK: - Properties

    private let session: URLSession
    private let baseStringURL: String = "https://geo.api.gouv.fr/departements/31/communes?"
    
    // MARK: - Initializer

    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    // MARK: - Methods

    func getCities(callback: @escaping (Result<CitiesData, NetworkError>) -> Void) {
        guard let baseURL: URL = .init(string: baseStringURL) else { return }
        let url: URL = encode(with: baseURL, and: [("fields","nom,codesPostaux,surface,population"),("format","json"),("geometry","centre")])
        session.dataTask(with: url, callback: callback)
    }
}

extension APICalls : URLEncodable {}
