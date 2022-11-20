//
//  MarketListViewController.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 17.11.22.
//

import UIKit

protocol MarketListDisplayLogic: AnyObject {
    func displayMarketList(_ viewModel: MarketListModels.CoinList.ViewModel)
    func displayPrefetchedMarketList(_ viewModel: MarketListModels.CoinList.ViewModel)
}

final class MarketListViewController: UIViewController {
    
    // MARK: - Properties
    var interactor: MarketListBusinessLogic?
    var router: (MarketListRoutingLogic & MarketListDataPassing)?
    
    private lazy var contentView: MarketListViewLogic = MarketListView(parentViewController: self)
    private let searchMarketListViewController = SearchMarketListViewController()
    private lazy var searchController = UISearchController(searchResultsController: searchMarketListViewController)
    
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
        let interactor = MarketListInteractor()
        let presenter = MarketListPresenter()
        let router = MarketListRouter()
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
        setupSearchController()
        Task {
            await showMarketList()
        }
    }
    
    func startPrefetching(for page: Int) async {
        await interactor?.prefetchMarketList(with: MarketListModels.CoinList.Request(page: page))
    }
    
    func tableViewDidStartScrolling() {
        searchController.isActive = false
    }
    
    func didSelectRow(for id: String) {
        requestToSelectCoin(by: id)
        router?.routeToCoinDetail()
    }
    
    // MARK: - Private Methods
    private func setupNavigationItems() {
        title = "Crypto"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = searchMarketListViewController
    }
    
    private func showMarketList() async {
        let request = MarketListModels.CoinList.Request(page: 1)
        
        await interactor?.fetchMarketList(with: request)
    }
    
    private func requestToSelectCoin(by id: String) {
        let request = MarketListModels.SelectCoin.Request(id: id)
        
        interactor?.selectCoin(with: request)
    }
}

// MARK: - Display Logic
extension MarketListViewController: MarketListDisplayLogic {
    func displayMarketList(_ viewModel: MarketListModels.CoinList.ViewModel) {
        contentView.configure(with: viewModel.marketListCellModel)
    }
    
    func displayPrefetchedMarketList(_ viewModel: MarketListModels.CoinList.ViewModel) {
        contentView.updateModel(with: viewModel.marketListCellModel)
    }
}
