//
//  CryptoEndpoint.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 16.11.22.
//

import Foundation

enum CryptoEndpoint {
    case markets(CoinRequestModel)
    case search(String)
}

extension CryptoEndpoint: Endpoint {
    var path: String {
        switch self {
        case .markets:
            return "/api/v3/coins/markets"
        case .search:
            return "/api/v3/search"
        }
    }

    var method: RequestMethod {
        switch self {
        case .markets, .search:
            return .get
        }
    }

    var header: [String: String]? {
        switch self {
        case .markets, .search:
            return ["Content-Type": "application/json;charset=utf-8"]
        }
    }
    
    var query: [String : Any]? {
        switch self {
        case .markets(let model):
            return ["vs_currency": model.vsCurrency,
                    "order": model.order,
                    "per_page": "\(model.perPage)",
                    "page": "\(model.page)",
                    "current_price": model.vsCurrency,
                    "price_change_percentage": model.priceChangePercentage]
        case .search(let searchWord):
            return ["query": searchWord]
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .markets, .search:
            return nil
        }
    }
}
