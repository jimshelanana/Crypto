//
//  CryptoEndpoint.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 16.11.22.
//

import Foundation

enum CryptoEndpoint {
    case markets(CoinRequestModel)
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
    
    var query: [String : Any]? {
        switch self {
        case .markets(let model):
            return ["vs_currency": model.vsCurrency,
                    "order": model.order,
                    "per_page": "\(model.perPage)",
                    "page": "\(model.page)",
                    "current_price": model.vsCurrency,
                    "price_change_percentage": model.priceChangePercentage]
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .markets:
            return nil
        }
    }
}
