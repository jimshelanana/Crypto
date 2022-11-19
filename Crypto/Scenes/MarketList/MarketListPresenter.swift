//
//  MarketListPresenter.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 17.11.22.
//

import UIKit

protocol MarketListPresentationLogic {
    func presentData(_ response: MarketListModels.FetchCoins.Response)
    func presentPrefetchedData(_ response: MarketListModels.FetchCoins.Response)
}

final class MarketListPresenter: MarketListPresentationLogic {
    
    typealias MarketListCellModel = MarketListModels.FetchCoins.MarketListCellModel
    
    // MARK: - Properties
    weak var viewController: MarketListDisplayLogic?
    
    // MARK: - Presentation Logic
    func presentData(_ response: MarketListModels.FetchCoins.Response) {
        viewController?.displayMarketList(MarketListModels.FetchCoins.ViewModel(marketListCellModel:
                                                                                    getMarketListCellModel(response.list)))
    }
    
    func presentPrefetchedData(_ response: MarketListModels.FetchCoins.Response) {
        viewController?.displayPrefetchedMarketList(MarketListModels.FetchCoins.ViewModel(marketListCellModel: getMarketListCellModel(response.list)))
    }
    
    private func getMarketListCellModel(_ coinModel: [CoinModel]) -> [MarketListCellModel] {
        coinModel.map { setupMarketListCellModel(from: $0) }
    }
    
    private func setupMarketListCellModel(from model: CoinModel) -> MarketListCellModel {
        return MarketListCellModel(
            id: model.id ?? "",
            symbol: model.symbol?.uppercased() ?? "",
            name: model.name ?? "",
            image: model.image ?? "",
            currentPrice: "$\(model.currentPrice ?? 0)",
            priceChangePercentageOneDay: "\(model.priceChangePercentageOneDay?.percentString ?? "0")",
            isPriceChangePositive: model.priceChangePercentageOneDay?.sign == .plus
        )
    }
}
