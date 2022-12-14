//
//  MarketListCell.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 17.11.22.
//

import UIKit

final class MarketListCell: UITableViewCell, CellIdentifiable {
    // MARK: - Properties
    static var identifier = String(describing: MarketListCell.self)
    
    // MARK: - Views
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
        stackView.spacing = 16
        stackView.layer.cornerRadius = 14
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor.systemGray.cgColor
        return stackView
    }()
    
    private var coinIcon: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return icon
    }()
    
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4
        stackView.axis = .vertical
        return stackView
    }()
    
    private let coinTitleLabel = UILabel()
    private let coinSymbolLabel = UILabel()
    
    private let priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4
        stackView.axis = .vertical
        return stackView
    }()
    
    private let coinPriceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()
    
    private let coinPriceChangeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func prepareForReuse() {
        super.prepareForReuse()
        coinTitleLabel.text = nil
        coinSymbolLabel.text = nil
        coinPriceLabel.text = nil
        coinPriceChangeLabel.text = nil
        coinIcon.image = nil
    }
    
    // MARK: - Setup
    private func setup() {
        setupView()
        addSubviews()
        addConstraints()
    }
    
    private func setupView() {
        selectionStyle = .none
    }
    
    private func addSubviews() {
        self.addSubview(mainStackView)
        mainStackView.addArrangedSubview(coinIcon)
        mainStackView.addArrangedSubview(titleStackView)
        titleStackView.addArrangedSubview(coinTitleLabel)
        titleStackView.addArrangedSubview(coinSymbolLabel)
        mainStackView.addArrangedSubview(priceStackView)
        priceStackView.addArrangedSubview(coinPriceLabel)
        priceStackView.addArrangedSubview(coinPriceChangeLabel)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            mainStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    // MARK: - Configure
    func configure(with model: MarketListCellModel) {
        coinTitleLabel.text = model.name
        coinSymbolLabel.text = model.symbol
        coinPriceLabel.text = model.currentPrice
        coinPriceChangeLabel.text = model.priceChangePercentageOneDay
        coinPriceChangeLabel.textColor = model.isPriceChangePositive == true ? .green : .red
        coinIcon.loadImage(from: model.image)
    }
}
