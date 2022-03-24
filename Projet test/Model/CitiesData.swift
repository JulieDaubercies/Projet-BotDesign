//
//  CitiesData.swift
//  Projet test
//
//  Created by DAUBERCIES on 24/03/2022.
//

import Foundation

// MARK: - WelcomeElement
struct MainData: Codable {
    let nom: String
    let codesPostaux: [String]
    let surface: Double
    let population: Int
    let code: String
}

typealias CitiesData = [MainData]
