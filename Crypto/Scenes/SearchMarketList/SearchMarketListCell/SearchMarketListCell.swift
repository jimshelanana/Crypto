//
//  SearchMarketListCell.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 19.11.22.
//

import UIKit

final class SearchMarketListCell: UITableViewCell, CellIdentifiable {
    // MARK: - Properties
    static var identifier = String(describing: SearchMarketListCell.self)
    private let imageLoadService = ImageLoadService()
    
    // MARK: - Views
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stackView.spacing = 10
        return stackView
    }()
    
    private var coinIcon: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        icon.contentMode = .scaleAspectFit
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
        coinIcon.loadImage(from: model.image)
    }
}
