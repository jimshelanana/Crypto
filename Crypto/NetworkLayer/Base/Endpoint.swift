//
//  Endpoint.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 16.11.22.
//

// MARK: - Endpoint
protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var query: [String: Any]? { get }
    var body: [String: String]? { get }
}

extension Endpoint {
    var scheme: String {
        "https"
    }
    
    var host: String {
        "api.coingecko.com"
    }
}
