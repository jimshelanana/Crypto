//
//  CryptoEndpoint.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 16.11.22.
//

import Foundation

enum CryptoEndpoint {
    case markets
}

extension CryptoEndpoint: Endpoint {
    var path: String {
        switch self {
        case .markets:
            return "/api/v3/coins/markets"
        }
    }

    var method: RequestMethod {
        switch self {
        case .markets:
            return .get
        }
    }

    var header: [String: String]? {
        switch self {
        case .markets:
            return ["Content-Type": "application/json;charset=utf-8"]
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .markets:
            return nil
        }
    }
}
