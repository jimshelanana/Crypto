//
//  CoinDetailPresenter.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 20.11.22.
//

import UIKit

protocol CoinDetailPresentationLogic {
    func presentCoinDetail(_ response: CoinDetailModels.CoinDetail.Response)
    func presentTrendingCoins(_ response: CoinDetailModels.Trending.Response)
    func presentServiceCallError(error: RequestError)
    func presentIsLoading(_ isLoading: Bool)
}

final class CoinDetailPresenter: CoinDetailPresentationLogic {
    
    // MARK: - Properties
    weak var viewController: CoinDetailDisplayLogic?
    
    // MARK: - Presentation Logic
    func presentCoinDetail(_ response: CoinDetailModels.CoinDetail.Response) {
        let currentPrice = "Current price: \(response.detail.marketData?.currentPrice["usd"] ?? 0)$"
        let priceChangeOneDay = "24h Change: \(response.detail.marketData?.priceChangeOneDay?.doubleString ?? "0")$"
        let priceChangePercentageOneDay = "\(response.detail.marketData?.priceChangePercentageOneDay?.percentString ?? "0")"
        let model = CoinDetailModels.CoinDetail.ViewModel(id: response.detail.id ?? "",
                                                          name: response.detail.name ?? "",
                                                          image: response.detail.image?.small ?? "",
                                                          link: response.detail.links?.homepage?[0] ?? "",
                                                          currentPriceInUSD: currentPrice,
                                                          marketCapRank: "\(response.detail.marketCapRank ?? 0)",
                                                          priceChangeOneDay: priceChangeOneDay,
                                                          priceChangePercentageOneDay: priceChangePercentageOneDay,
                                                          isPriceChangePositive: response.detail.marketData?.priceChangePercentageOneDay?.sign == .plus,
                                                          description: response.detail.description?.en ?? "")
        viewController?.displayCoinDetail(model)
    }
    
    func presentTrendingCoins(_ response: CoinDetailModels.Trending.Response) {
        let model = response.coins.coins.map { coin in
            CoinDetailModels.Trending.ViewModel(id: coin.item.id,
                                                name: coin.item.name,
                                                image: coin.item.image,
                                                marketRank: "#\(coin.item.marketRank ?? 0)")
        }
        
        viewController?.displayTrendingCoins(model)
    }
    
    func presentServiceCallError(error: RequestError) {
        viewController?.displayServiceCallError(error.localizedDescription)
    }
    
    func presentIsLoading(_ isLoading: Bool) {
        viewController?.displayIsLoading(isLoading)
    }
}
