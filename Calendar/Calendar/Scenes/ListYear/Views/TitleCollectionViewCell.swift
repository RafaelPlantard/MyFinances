//
//  TitleCollectionViewCell.swift
//  Calendar
//
//  Created by Rafael Ferreira on 12/31/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

import Core
import UIKit

public final class TitleCollectionViewCell: UICollectionViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: UIFont.buttonFontSize)
        label.numberOfLines = 2

        return label
    }()

    // MARK: Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupLayout()
        setupView()
    }

    // MARK: Functions

    func set(title: String) {
        titleLabel.text = title
    }

    // MARK: Private functions

    private func setupLayout() {
        addSubview(titleLabel, constraints: [
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }

    private func setupView() {
        layer.cornerRadius = 20
        backgroundColor = .white
    }
}
