//
//  NetworkError.swift
//  Projet test
//
//  Created by DAUBERCIES on 24/03/2022.
//

import Foundation

enum NetworkError: Error {
    case noData, invalidResponse, undecodableData
}

extension NetworkError: CustomStringConvertible {
    var description: String {
        switch self {
        case .noData:
            return "Le service est momentanément indisponible"
        case .invalidResponse:
            return "Erreur rencontrée lors de l'appel réseau"
        case .undecodableData:
            return "Cette ville ne contient aucune donnée"
        }
    }
}
