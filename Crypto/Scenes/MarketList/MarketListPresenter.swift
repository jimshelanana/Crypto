//
//  MarketListPresenter.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 17.11.22.
//

import UIKit

protocol MarketListPresentationLogic {
    func presentData(_ response: MarketListModels.FetchCoins.Response)
}

final class MarketListPresenter: MarketListPresentationLogic {
    // MARK: - Properties
    weak var viewController: MarketListDisplayLogic?

    // MARK: - Presentation Logic
    func presentData(_ response: MarketListModels.FetchCoins.Response) {
        var marketListCellModel = [MarketListModels.FetchCoins.MarketListCellModel]()
        
        response.list.forEach { model in
            let cellModel = setupMarketListCellModel(from: model)
            marketListCellModel.append(cellModel)
        }
        
        viewController?.displayMarketList(MarketListModels.FetchCoins.ViewModel(marketListCellModel: marketListCellModel))
    }
    
    private func setupMarketListCellModel(from model: CoinModel) -> MarketListModels.FetchCoins.MarketListCellModel {
        return MarketListModels.FetchCoins.MarketListCellModel(
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
