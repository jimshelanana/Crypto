//
//  CoinDetailRouter.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 20.11.22.
//

import UIKit

protocol CoinDetailRoutingLogic {
    func routeToWebLink()
}

protocol CoinDetailDataPassing {
    var dataStore: CoinDetailDataStore? { get }
}

final class CoinDetailRouter: CoinDetailRoutingLogic, CoinDetailDataPassing {
    
    // MARK: - Properties
    weak var viewController: CoinDetailViewController?
    var dataStore: CoinDetailDataStore?
    
    // MARK: - Routing Logic
    func routeToWebLink() {
        guard let link = dataStore?.selectedLink else { return }
        let url = URL.init(string: link)
        guard let url = url else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
