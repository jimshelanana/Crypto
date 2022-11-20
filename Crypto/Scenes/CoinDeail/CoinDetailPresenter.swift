//
//  CoinDetailPresenter.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 20.11.22.
//

import UIKit

protocol CoinDetailPresentationLogic {
    func presentCoinDetail(_ response: CoinDetailModels.CoinDetail.Response)
}

final class CoinDetailPresenter: CoinDetailPresentationLogic {
    
    // MARK: - Properties
    weak var viewController: CoinDetailDisplayLogic?
    
    // MARK: - Presentation Logic
    func presentCoinDetail(_ response: CoinDetailModels.CoinDetail.Response) {
        let currentPrice = response.detail.marketData?.currentPrice["usd"]
        let priceChangeOneDay = "24h Change: \(response.detail.marketData?.priceChangeOneDay?.doubleString ?? "0")$"
        let priceChangePercentageOneDay = "\(response.detail.marketData?.priceChangePercentageOneDay?.percentString ?? "0")"
        let model = CoinDetailModels.CoinDetail.ViewModel(id: response.detail.id ?? "",
                                                          name: response.detail.name ?? "",
                                                          image: response.detail.image?.small ?? "",
                                                          link: response.detail.links?.homepage?[0] ?? "",
                                                          currentPriceInUSD: "\(currentPrice ?? 0)$",
                                                          marketCapRank: "\(response.detail.marketCapRank ?? 0)",
                                                          priceChangeOneDay: priceChangeOneDay,
                                                          priceChangePercentageOneDay: priceChangePercentageOneDay,
                                                          isPriceChangePositive: response.detail.marketData?.priceChangePercentageOneDay?.sign == .plus)
        viewController?.displayCoinDetail(model)
    }
}
