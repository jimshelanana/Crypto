//
//  SearchMarketListViewController.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 19.11.22.
//

import UIKit

protocol SearchMarketListDisplayLogic: AnyObject {
    func displaySearchedMarketList(_ viewModel: SearchMarketListModels.CoinList.ViewModel)
    func displayIsLoading(_ isLoading: Bool)
}

final class SearchMarketListViewController: UIViewController {
    
    // MARK: - Public Properties
    var interactor: SearchMarketListBusinessLogic?
    var router: (SearchMarketListRoutingLogic & SearchMarketListDataPassing)?
    
    private lazy var contentView: SearchMarketListViewLogic = SearchMarketListView(parentViewController: self)
    
    // MARK: - Init
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        let interactor = SearchMarketListInteractor()
        let presenter = SearchMarketListPresenter()
        let router = SearchMarketListRouter()
        
        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        router.dataStore = interactor
        
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        view = contentView
    }
    
    func didSelectRow(for id: String) {
        requestToSelectCoin(by: id)
        router?.routeToCoinDetail()
    }
    
    // MARK: - Private Methods
    private func requestToSelectCoin(by id: String) {
        let request = SearchMarketListModels.SelectCoin.Request(id: id)
        
        interactor?.selectCoin(with: request)
    }
}

// MARK: - Display Logic
extension SearchMarketListViewController: SearchMarketListDisplayLogic {
    func displaySearchedMarketList(_ viewModel: SearchMarketListModels.CoinList.ViewModel) {
        contentView.configure(with: viewModel.searchListCellModel)
    }
}


// MARK: - UISearchResultsUpdating
extension SearchMarketListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            interactor?.fetchSearchMarketList(with: SearchMarketListModels.CoinList.Request(searchWord: searchText))
        }
    }
    
    func displayIsLoading(_ isLoading: Bool) {
        contentView.isLoadingActivateIndicator(isLoading)
    }
}
