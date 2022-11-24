//
//  CoinDetailRouter.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 20.11.22.
//

import UIKit

protocol CoinDetailRoutingLogic {
    func routeToWebLink()
    func routeToCoinDetailPage()
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
    
    func routeToCoinDetailPage() {
        let coinDetailVC = CoinDetailViewController()
        guard var coinDetailDataStore = coinDetailVC.router?.dataStore else { return }
        coinDetailDataStore.selectedCoin = dataStore?.selectedCoin
        guard let allButCurrentController = viewController?.navigationController?.viewControllers.dropLast() else {
            viewController?.present(coinDetailVC, animated: true)
            return
        }
        let controllers = Array(allButCurrentController) + [coinDetailVC]
        viewController?.navigationController?.setViewControllers(controllers, animated: true)
    }
}
