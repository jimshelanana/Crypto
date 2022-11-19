//
//  SearchMarketListPresenter.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 19.11.22.
//

import UIKit

protocol SearchMarketListPresentationLogic {
    func presentSearchData(_ response: SearchMarketListModels.CoinList.Response)
}

final class SearchMarketListPresenter: SearchMarketListPresentationLogic {
    
    // MARK: - Public Properties
    
    weak var viewController: SearchMarketListDisplayLogic?
    
    // MARK: - Presentation Logic
    func presentSearchData(_ response: SearchMarketListModels.CoinList.Response) {
        let model = response.list.coins.map { item in
            MarketListCellModel(id: item.id ?? "",
                                symbol: item.symbol ?? "",
                                name: item.name ?? "",
                                image: item.image ?? "")
        }
        viewController?.displaySearchedMarketList(.init(searchListCellModel: model))
    }
}
