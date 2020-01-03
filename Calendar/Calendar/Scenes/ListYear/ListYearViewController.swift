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
    func displayFetchedMonths(viewModel: ListYear.FetchMonths.ViewModel)
}

final class ListYearViewController: UIViewController, ListYearDisplayLogic {
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = UIColor.systemGray6
        collectionView.register(
            TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.className
        )
        collectionView.register(
            TitleCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TitleCollectionReusableView.className
        )

        return collectionView
    }()

    private let segmentControl: UISegmentedControl = {
        let localizable = Localizable.Calendar.Segment.self
        let control = UISegmentedControl(items: [localizable.years, localizable.months])
        control.selectedSegmentIndex = 0

        return control
    }()

    // MARK: Private lazy variables

    private lazy var yearDelegate: UICollectionViewDelegateFlowLayout = {
        YearCollectionViewDelegate { [weak self] indexPath in
            let request = ListYear.FetchMonths.Request(indexPath: indexPath)

            self?.interactor.fetchMonths(request: request)
        }
    }()

    private lazy var monthDelegate: UICollectionViewDelegateFlowLayout = MonthCollectionViewDelegate()

    // MARK: Private constants

    private let yearDataSource: UICollectionViewDataSource & DataSource = CollectionViewDataSource.make(for: [])

    private let monthDataSource: UICollectionViewDataSource & DataSource = CollectionViewDataSource.make(for: [])

    private lazy var sectionDataSource: UICollectionViewDataSource & DataSource = {
        SectionedCollectionViewDataSource.make(dataSources: [monthDataSource])
    }()

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
        setupActions()
        fetch()
    }

    // MARK: ListYearDisplayLogic conforms

    func displayFetchedYears(viewModel: ListYear.FetchYears.ViewModel) {
        yearDataSource.set(models: viewModel.years)
        collectionView.dataSource = yearDataSource
        collectionView.delegate = yearDelegate
    }

    func displayFetchedMonths(viewModel: ListYear.FetchMonths.ViewModel) {
        sectionDataSource.set(models: [viewModel.year])
        monthDataSource.set(models: viewModel.months)
        collectionView.dataSource = sectionDataSource
        collectionView.delegate = monthDelegate
        segmentControl.selectedSegmentIndex = 1
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

    private func setupActions() {
        segmentControl.addTarget(self, action: .didSegmentChanged, for: .valueChanged)
    }

    // MARK: Fileprivate functions

    @objc
    fileprivate func onDidSegmentControlChanged() {
        let request = ListYear.ChangeRange.Request(index: segmentControl.selectedSegmentIndex)

        interactor.changeRange(request: request)
    }
}

private extension Selector {
    static let didSegmentChanged = #selector(ListYearViewController.onDidSegmentControlChanged)
}

private extension CollectionViewDataSource where Model == String {
    static func make(for years: [Model]) -> CollectionViewDataSource<String, TitleCollectionViewCell> {
        CollectionViewDataSource<String, TitleCollectionViewCell>(models: years) { (model, cell) in
            cell.set(title: model)
        }
    }
}

private extension SectionedCollectionViewDataSource where Model == String, Cell == TitleCollectionReusableView {
    static func make(dataSources: [UICollectionViewDataSource]) -> SectionedCollectionViewDataSource {
        SectionedCollectionViewDataSource(sections: dataSources, sectionTitles: []) { (model, cell) in
            cell.set(title: model)
        }
    }
}
