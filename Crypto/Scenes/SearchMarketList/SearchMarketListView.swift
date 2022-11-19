//
//  SearchMarketListView.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 19.11.22.
//

import UIKit

protocol SearchMarketListViewLogic: UIView {
    func configure(with model: [MarketListCellModel])
}

final class SearchMarketListView: UIView {
    
    // MARK: - Properties
    private var parentViewController: SearchMarketListViewController?
    private var model = [MarketListCellModel]()
    
    // MARK: - Views
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = true
        tableView.showsVerticalScrollIndicator = true
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    // MARK: - Init
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        setup()
    }
    
    convenience init(parentViewController: SearchMarketListViewController) {
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
        tableView.register(SearchMarketListCell.self, forCellReuseIdentifier: "SearchMarketListCell")
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
extension SearchMarketListView: SearchMarketListViewLogic {
    func configure(with model: [MarketListCellModel]) {
        self.model = model
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - TableView DataSource
extension SearchMarketListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SearchMarketListCell") as? SearchMarketListCell {
            cell.configure(with: model[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - TableView Delegate
extension SearchMarketListView: UITableViewDelegate {
    
}
