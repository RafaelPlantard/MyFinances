//
//  ListYearViewController.swift
//  Calendar
//
//  Created by Rafael Ferreira on 12/31/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

import Core
import UIKit

final class ListYearViewController: UIViewController {
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = UIColor.systemGray6
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.className)

        return collectionView
    }()

    private let segmentControl: UISegmentedControl = {
        let localizable = Localizable.Calendar.Segment.self
        let control = UISegmentedControl(items: [localizable.years, localizable.months, localizable.all])
        control.selectedSegmentIndex = 0

        return control
    }()

    // MARK: Private constants

    private let dataSource: UICollectionViewDataSource = CollectionViewDataSource.make(for: ["2018", "2019", "2020"])
    private let delegate: UICollectionViewDelegateFlowLayout = YearCollectionViewDelegate()

    // MARK: Override functions

    override func loadView() {
        super.loadView()

        setupLayout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    // MARK: Private functions

    private func setupLayout() {
        view.addSubview(equalConstraintsFor: collectionView)

        view.addSubview(segmentControl, constraints: [
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            segmentControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }

    private func setupView() {
        title = Localizable.Calendar.title
    }
}

private extension CollectionViewDataSource where Model == String {
    static func make(for years: [Model]) -> CollectionViewDataSource<String,TitleCollectionViewCell> {
        CollectionViewDataSource<String, TitleCollectionViewCell>(models: years) { (model, cell) in
            cell.set(title: model)
        }
    }
}
