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
        guard let coinDetailVC = getCoinDetailVC() else { return }
        if UIDevice.current.userInterfaceIdiom == .pad {
            let splitVC = UISplitViewController(style: .doubleColumn)
            splitVC.viewControllers = [
                MarketListViewController(),
                coinDetailVC
            ]
            viewController?.view.window?.rootViewController = splitVC
        } else {
            viewController?.present(coinDetailVC, animated: true)
        }
    }
    
    // MARK: - Private Methods
    private func getCoinDetailVC() -> UIViewController? {
        let coinDetailVC = CoinDetailViewController()
        guard var coinDetailDataStore = coinDetailVC.router?.dataStore else { return nil }
        coinDetailDataStore.selectedCoin = dataStore?.selectedCoin
        return coinDetailVC
    }
}
