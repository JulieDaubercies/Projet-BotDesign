//
//  APICallsTestCase.swift
//  Projet testTests
//
//  Created by DAUBERCIES on 30/03/2022.
//

import XCTest
@testable import Projet_test

class APICallsTestCase: XCTestCase {


    // MARK: - Properties

    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [URLProtocolFake.self]
        return sessionConfiguration
    }()

    
    // MARK: - Tests

    func testFetchCitiesList_WhenFakeSessionWithErrorIsPassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [FakeResponseData.urlApi: (nil, nil, FakeResponseData.error)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: APICalls = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting")
        sut.getCities { result in
            guard case .failure(let error) = result else {
                XCTFail("test failed")
                return
            }
            
            XCTAssertTrue(error == .noData)
            XCTAssertTrue(error.description == "Le service est momentanément indisponible")
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testsFetchCitiesList_WhenFakeSessionWithCorrectDataAndInvalidResponseArePassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [FakeResponseData.urlApi: (FakeResponseData.correctData, FakeResponseData.responseKO, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: APICalls = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting")
        sut.getCities { result in
            guard case .failure(let error) = result else {
                XCTFail("Test failed")
                return
            }
            XCTAssertTrue(error == .invalidResponse)
            XCTAssertTrue(error.description == "Erreur rencontrée lors de l'appel réseau")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testsFetchFetchCitiesList_WhenFakeSessionWithIncorrectDataAndValidResponseArePassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [FakeResponseData.urlApi: (FakeResponseData.incorrectData, FakeResponseData.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: APICalls = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting")
        sut.getCities { result in
            guard case .failure(let error) = result else {
                XCTFail("Test failed")
                return
            }
            print(error)
            XCTAssertTrue(error == .undecodableData)
            XCTAssertTrue(error.description == "Cette ville ne contient aucune donnée")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testsFetchFetchCitiesList_WhenFakeSessionWithCorrectDataAndValidResponseArePassed_ThenShouldReturnCorrectData() {
        URLProtocolFake.fakeURLs = [FakeResponseData.urlApi: (FakeResponseData.correctData, FakeResponseData.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: APICalls = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting")
        sut.getCities { result in
            guard case .success(let city) = result else {
                XCTFail("Test failed")
                return
            }

            XCTAssertTrue(city[0].nom == "Agassac")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }


}
