//
//  RequestError.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 16.11.22.
//

import Foundation

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unAuthorized
    case unexpectedStatusCode
    case imageDownloadFailed
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .unAuthorized:
            return "Session expired"
        default:
            return "Unknown error"
        }
    }
}
