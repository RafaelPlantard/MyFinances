//
//  ListYearViewController.swift
//  Calendar
//
//  Created by Rafael Ferreira on 12/31/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

import Core
import UIKit

protocol ListYearDisplayLogic: AnyObject {
    func displayFetchedYears(viewModel: ListYear.FetchYears.ViewModel)
}

final class ListYearViewController: UIViewController, ListYearDisplayLogic {
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
        let control = UISegmentedControl(items: [localizable.years, localizable.months])
        control.selectedSegmentIndex = 0

        return control
    }()

    // MARK: Private constants

    private let dataSource: UICollectionViewDataSource & DataSource = CollectionViewDataSource.make(for: [])
    private let delegate: UICollectionViewDelegateFlowLayout = YearCollectionViewDelegate()
    private let interactor: ListYearBusinessLogic

    // MARK: Initializers

    init(interactor: ListYearBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: Override functions

    override func loadView() {
        super.loadView()

        setupLayout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        fetch()
    }

    // MARK: ListYearDisplayLogic conforms

    func displayFetchedYears(viewModel: ListYear.FetchYears.ViewModel) {
        dataSource.set(models: viewModel.years)
    }

    // MARK: Private functions

    private func fetch() {
        interactor.fetchYears()
    }

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
