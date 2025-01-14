//
//  CoinCell.swift
//  CoinApp
//
//  Created by Angie Mugo on 09/01/2025.
//

import Foundation
import UIKit
import SDWebImageSVGCoder

class CoinCell: UITableViewCell, ReusableView, NibProvidable {

    @UsesAutoLayout
    private(set) var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        return imageView
    }()

    @UsesAutoLayout
    private(set) var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.textColor = .label
        return label
    }()

    @UsesAutoLayout
    private(set) var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        return label
    }()

    @UsesAutoLayout
    private(set) var performanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1
        return label
    }()

    @UsesAutoLayout
    private(set) var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.2
        imageView.layer.shadowOffset = CGSize(width: 0, height: 1)
        imageView.layer.shadowRadius = 4
        imageView.image = UIImage(systemName: "bitcoinsign")
        return imageView
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellAppearance()
        setupSubviews()
        setupConstraints()
    }

    private func setupCellAppearance() {
        backgroundColor = .systemBackground
        selectionStyle = .none
    }

    private func setupSubviews() {
        [iconImageView, nameLabel, priceLabel, performanceLabel, starImageView].forEach {
            addSubview($0)
        }
    }

    private func setupConstraints() {
        iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.defaultSpacing).activate()
        iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: Layout.defaultSpacing).activate()
        iconImageView.heightAnchor.constraint(equalToConstant: 20).activate()
        iconImageView.widthAnchor.constraint(equalToConstant: 20).activate()

        nameLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor).activate()
        nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: Layout.defaultSpacing).activate()
        nameLabel.trailingAnchor.constraint(equalTo: starImageView.leadingAnchor, constant: -Layout.defaultSpacing).activate()

        priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Layout.defaultSpacing).activate()
        priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.defaultSpacing).activate()
        priceLabel.trailingAnchor.constraint(equalTo: starImageView.leadingAnchor, constant: -Layout.defaultSpacing).activate()

        performanceLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: Layout.defaultSpacing).activate()
        performanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.defaultSpacing).activate()
        performanceLabel.trailingAnchor.constraint(equalTo: starImageView.leadingAnchor, constant: -Layout.defaultSpacing).activate()

        starImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.defaultSpacing).activate()
        starImageView.centerYAnchor.constraint(equalTo: centerYAnchor).activate()
        starImageView.widthAnchor.constraint(equalToConstant: 20).activate()
        starImageView.heightAnchor.constraint(equalToConstant: 20).activate()
    }

    func configure(coin: UICoinModel) {
        nameLabel.text = coin.name
        priceLabel.text = coin.price.formattedCurrency()
        performanceLabel.text = coin.currentPerformance.formattedCurrency()
        starImageView.tintColor = coin.isFavorite ? .systemPurple : .systemGray
        loadIconImage(from: coin.icon)
    }

    private func loadIconImage(from url: String) {
        guard let imageUrl = URL(string: url) else { return }
        iconImageView.sd_setImage(with: imageUrl)
    }
}

