//
//  SearchModel.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 19.11.22.
//

import Foundation

struct SearchModel: Codable {
    let coins: [SearchCoinModel]
}

struct SearchCoinModel: Codable {
    let id: String?
    let symbol: String?
    let name: String?
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case image = "large"
    }
}
