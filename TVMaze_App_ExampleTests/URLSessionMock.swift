//
//  URLSessionMock.swift
//  TVMaze_App_ExampleTests
//
//  Created by Adrian Iraizos Mendoza on 2/5/24.
//

import Foundation

final class URLSessionMock: URLProtocol {
    let showsUrl = Bundle(for: CatalogueModelLogicTests.self).url(forResource: "ShowTests", withExtension: "json")!
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
            if let data = try? Data(contentsOf: showsUrl) {
                client?.urlProtocol(self, didLoad: data)
                if let response = HTTPURLResponse(url: showsUrl, statusCode: 200, httpVersion: nil, headerFields: ["Content-Type": "application/json"]) {
                    client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                }
            }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() { }
    
}
    

