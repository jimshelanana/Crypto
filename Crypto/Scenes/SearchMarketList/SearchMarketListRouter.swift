//
//  SearchMarketListRouter.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 19.11.22.
//

import UIKit

protocol SearchMarketListRoutingLogic {
    func routeToCoinDetail() 
}

protocol SearchMarketListDataPassing {
    var dataStore: SearchMarketListDataStore? { get }
}

final class SearchMarketListRouter: SearchMarketListRoutingLogic, SearchMarketListDataPassing {
    
    // MARK: - Public Properties
    weak var viewController: SearchMarketListViewController?
    var dataStore: SearchMarketListDataStore?
    
    // MARK: - RoutingLogic
    func routeToCoinDetail() {
        let coinDetailVC = CoinDetailViewController()
        guard var coinDetailDataStore = coinDetailVC.router?.dataStore else { return }
        coinDetailDataStore.selectedCoin = dataStore?.selectedCoin
        viewController?.present(coinDetailVC, animated: true)
    }
}
