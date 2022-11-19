//
//  MarketListView.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 17.11.22.
//

import UIKit

protocol MarketListViewLogic: UIView {
    func configure(with model: [MarketListModels.FetchCoins.MarketListCellModel])
    func updateModel(with prefetchedItems: [MarketListModels.FetchCoins.MarketListCellModel])
}

final class MarketListView: UIView {
    
    typealias CellModel = [MarketListModels.FetchCoins.MarketListCellModel]
    
    // MARK: - Properties
    private var parentViewController: MarketListViewController?
    private var model = CellModel()
    private var marketListPage = 1
    private var isLoadingData = true
    
    // MARK: - Views    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = true
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    // MARK: - Init
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        setup()
    }
    
    convenience init(parentViewController: MarketListViewController) {
        self.init()
        self.parentViewController = parentViewController
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods
    private func setup() {
        setupUI()
        addSubviews()
        addConstraints()
        registerCell()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func registerCell() {
        tableView.register(MarketListCell.self, forCellReuseIdentifier: "MarketListCell")
    }
    
    private func setupUI() {
        backgroundColor = UIColor(named: "AccentColor")
    }
    
    private func addSubviews() {
        self.addSubview(tableView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - MarketListViewLogic
extension MarketListView: MarketListViewLogic {
    func configure(with model: CellModel) {
        self.model = model
        DispatchQueue.main.async {
            self.isLoadingData = false
            self.tableView.reloadData()
        }
    }
    
    func updateModel(with prefetchedItems: CellModel) {
        model.append(contentsOf: prefetchedItems)
        DispatchQueue.main.async {
            self.isLoadingData = false
            self.tableView.reloadData()
        }
    }
}

// MARK: - TableView DataSource
extension MarketListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MarketListCell") as? MarketListCell {
            cell.configure(with: model[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - TableView Delegate
extension MarketListView: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > tableView.contentSize.height - 100 - scrollView.frame.size.height && isLoadingData == false {
            marketListPage += 1
            isLoadingData = true
            Task {
                await parentViewController?.startPrefetching(for: marketListPage)
            }
        }
    }
}
