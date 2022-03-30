//
//  URLProtocolFake.swift
//  Projet testTests
//
//  Created by DAUBERCIES on 30/03/2022.
//

import Foundation

class URLProtocolFake: URLProtocol {
    
// MARK: - Properties

static var fakeURLs = [URL?: (data: Data?, response: HTTPURLResponse?, error: Error?)]()

// MARK: - Methods

override class func canInit(with request: URLRequest) -> Bool { true }
override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

override func startLoading() {
    if let url = request.url {
        if let (data, response, error) = URLProtocolFake.fakeURLs[url] {
            if let responseStrong = response {
                client?.urlProtocol(self, didReceive: responseStrong, cacheStoragePolicy: .notAllowed)
            }
            if let dataStrong = data {
                client?.urlProtocol(self, didLoad: dataStrong)
            }
            if let errorStrong = error {
                client?.urlProtocol(self, didFailWithError: errorStrong)
            }
        }
    }
    client?.urlProtocolDidFinishLoading(self)
}

override func stopLoading() {}
}
