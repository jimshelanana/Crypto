//
//  MarketListViewController.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 17.11.22.
//

import UIKit

protocol MarketListDisplayLogic: AnyObject {
    func displayMarketList(_ viewModel: MarketListModels.FetchCoins.ViewModel)
    func displayPrefetchedMarketList(_ viewModel: MarketListModels.FetchCoins.ViewModel)
}

final class MarketListViewController: UIViewController {
    
    // MARK: - Properties
    var interactor: MarketListBusinessLogic?
    var router: (MarketListRoutingLogic & MarketListDataPassing)?
    
    private lazy var contentView: MarketListViewLogic = MarketListView(parentViewController: self)
    private let searchController = UISearchController()
    
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
        Task {
            await showMarketList()
        }
    }
    
    func startPrefetching(for page: Int) async {
        await interactor?.prefetchMarketList(with: MarketListModels.FetchCoins.Request(page: page))
    }
    
    // MARK: - Private Methods
    private func setupNavigationItems() {
        title = "Crypto"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func showMarketList() async {
        let request = MarketListModels.FetchCoins.Request(page: 1)
        
        await interactor?.fetchMarketList(with: request)
    }
}

// MARK: - Display Logic
extension MarketListViewController: MarketListDisplayLogic {
    func displayMarketList(_ viewModel: MarketListModels.FetchCoins.ViewModel) {
        contentView.configure(with: viewModel.marketListCellModel)
    }
    
    func displayPrefetchedMarketList(_ viewModel: MarketListModels.FetchCoins.ViewModel) {
        contentView.updateModel(with: viewModel.marketListCellModel)
    }
}
