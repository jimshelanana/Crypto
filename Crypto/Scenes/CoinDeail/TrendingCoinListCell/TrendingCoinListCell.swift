//
//  TrendingCoinListCell.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 23.11.22.
//

import UIKit

final class TrendingCoinListCell: UICollectionViewCell, CellIdentifiable {
    // MARK: - Properties
    static var identifier = String(describing: TrendingCoinListCell.self)
    
    // MARK: - Views
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 12, bottom: 16, right: 12)
        stackView.spacing = 10
        return stackView
    }()
    
    private let coinRankingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let rankingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let nameLabel = UILabel()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        iconImageView.image = nil
    }
    
    // MARK: - Setup
    private func setup() {
        setupView()
        addSubviews()
        addConstraints()
    }
    
    private func setupView() {
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemGray.cgColor
        contentView.layer.masksToBounds = true
    }
    
    private func addSubviews() {
        self.addSubview(mainStackView)
        mainStackView.addArrangedSubview(coinRankingStackView)
        coinRankingStackView.addArrangedSubview(iconImageView)
        coinRankingStackView.addArrangedSubview(rankingLabel)
        mainStackView.addArrangedSubview(nameLabel)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 42)
        ])
    }
    
    // MARK: - Configure
    func configure(with model: CoinDetailModels.Trending.ViewModel) {
        nameLabel.text = model.name
        rankingLabel.text = model.marketRank
        iconImageView.loadImage(from: model.image)
    }
}
