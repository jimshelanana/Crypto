//
//  CryptoEndpoint.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 16.11.22.
//

import Foundation

// MARK: - CryptoEndpoint
enum CryptoEndpoint {
    case markets(CoinRequestModel)
    case search(String)
    case detail(String)
    case trending
}

extension CryptoEndpoint: Endpoint {
    var path: String {
        switch self {
        case .markets:
            return "/api/v3/coins/markets"
        case .search:
            return "/api/v3/search"
        case .detail(let id):
            return "/api/v3/coins/\(id)"
        case .trending:
            return "/api/v3/search/trending"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .markets, .search, .detail, .trending:
            return .get
        }
    }
    
    var header: [String: String]? {
        switch self {
        case .markets, .search, .detail, .trending:
            return ["Content-Type": "application/json;charset=utf-8"]
        }
    }
    
    var query: [String: Any]? {
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
        case .detail:
            return ["localization": false,
                    "tickers": false,
                    "community_data": false,
                    "developer_data": false]
        case .trending:
            return nil
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .markets, .search, .detail, .trending:
            return nil
        }
    }
}
