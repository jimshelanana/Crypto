//
//  MarketListRouter.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 17.11.22.
//

import UIKit

protocol MarketListRoutingLogic {
    func routeToCoinDetail()
}

protocol MarketListDataPassing {
    var dataStore: MarketListDataStore? { get }
}

final class MarketListRouter: MarketListRoutingLogic, MarketListDataPassing {
    
    // MARK: - Public Properties
    weak var viewController: MarketListViewController?
    var dataStore: MarketListDataStore?
    
    // MARK: - RoutingLogic
    func routeToCoinDetail() {
        let coinDetailVC = CoinDetailViewController()
        guard var coinDetailDataStore = coinDetailVC.router?.dataStore else { return }
        coinDetailDataStore.selectedCoin = dataStore?.selectedCoin
        viewController?.navigationController?.pushViewController(coinDetailVC, animated: true)
    }
}
