//
//  ListViewModel.swift
//  Projet test
//
//  Created by DAUBERCIES on 24/03/2022.
//

import Foundation

protocol CitiesNetworkServiceDelegate: AnyObject {
    func didCompleteRequest(result: [MainData])
}

class ListViewModel {
    
    private var apiCallsService = APICalls()
    var delegate: CitiesNetworkServiceDelegate?
    
    func launchListOfCities() {
        apiCallsService.getCities { [weak self] result in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let list):
                    self?.delegate?.didCompleteRequest(result: list)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
}
