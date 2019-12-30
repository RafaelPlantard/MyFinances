//
//  IncomeViewController.swift
//  Income
//
//  Created by Rafael Ferreira on 12/15/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

import Core
import UIKit

protocol IncomeListDisplayLogic: AnyObject {
    func displayFetchedIncomes(viewModel: IncomeList.FetchIncomes.ViewModel)
    func displayDeletedIncome(viewModel: IncomeList.DeleteIncome.ViewModel)
    func displayDeletedIncomeError()
}

final class IncomeListViewControler: UIViewController, IncomeListDisplayLogic, UITableViewDelegate {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = dataSource
        tableView.allowsSelection = false
        tableView.register(Value1TableViewCell.self, forCellReuseIdentifier: Value1TableViewCell.className)

        return tableView
    }()

    // MARK: Variables

    weak var delegate: IncomeListViewControllerDelegate?

    // MARK: Private variables

    private lazy var dataSource: EditingTableViewDataSource<DisplayIncomeList, Value1TableViewCell>? = {
        EditingTableViewDataSource<DisplayIncomeList, Value1TableViewCell>.make(
            for: [], then: { [weak self] (commit, indexPath) in
                self?.on(commit: commit, forRowAt: indexPath)
            }
        )
    }()

    // MARK: Private constants

    private let interactor: IncomeListBusinessLogic

    // MARK: Initializer

    init(interactor: IncomeListBusinessLogic) {
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupNavigationBar()
    }

    // MARK: Functions

    func fetch() {
        interactor.fetchIncomes()
    }

    // MARK: IncomeListDisplayLogic conforms

    func displayFetchedIncomes(viewModel: IncomeList.FetchIncomes.ViewModel) {
        dataSource?.set(models: viewModel.displayedIncomes)
        tableView.reloadData()
    }

    func displayDeletedIncome(viewModel: IncomeList.DeleteIncome.ViewModel) {
        dataSource?.set(models: viewModel.displayedIncomes)
        tableView.deleteRows(at: [viewModel.deletedIndexPath], with: .automatic)
    }

    func displayDeletedIncomeError() {
    }

    // MARK: Private functions

    private func setupLayout() {
        view.addSubview(equalConstraintsFor: tableView)
    }

    private func setupView() {
        title = Localizable.List.title
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self, action: .onAddTapped
        )
    }

    private func on(commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let request = IncomeList.DeleteIncome.Request(style: editingStyle, indexPath: indexPath)

        interactor.editIncome(request: request)
    }

    // MARK: Fileprivate functions

    @objc
    fileprivate func onRightBarButtonTapped() {
        delegate?.incomeListRightBarButtonItemTapped(self)
    }
}

private extension EditingTableViewDataSource where Model == DisplayIncomeList {
    static func make(for incomes: [Model], then handler: @escaping EditingConfigurator) -> EditingTableViewDataSource {
        return EditingTableViewDataSource(models: incomes, cellConfigurator: { (model, cell) in
            cell.textLabel?.text = model.name
            cell.detailTextLabel?.text = model.value
        }, editingConfigurator: handler)
    }
}

private extension Selector {
    static let onAddTapped = #selector(IncomeListViewControler.onRightBarButtonTapped)
}
