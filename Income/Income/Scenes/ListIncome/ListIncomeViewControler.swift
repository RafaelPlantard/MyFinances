//
//  ListIncomeViewControler.swift
//  Income
//
//  Created by Rafael Ferreira on 12/15/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

import Core
import UIKit

protocol ListIncomeDisplayLogic: AnyObject {
    func displayFetchedIncomes(viewModel: ListIncome.FetchIncomes.ViewModel)
    func displayDeletedIncome(viewModel: ListIncome.DeleteIncome.ViewModel)
    func displayDeletedIncomeError()
}

final class ListIncomeViewControler: UIViewController, ListIncomeDisplayLogic, UITableViewDelegate {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = dataSource
        tableView.allowsSelection = false
        tableView.register(Value1TableViewCell.self, forCellReuseIdentifier: Value1TableViewCell.className)

        return tableView
    }()

    private let tableFooterSeparatorView: UIView = UIView(backgroundColor: .separator)

    private let tableFooterViewCell: UITableViewCell = {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: UITableViewCell.className)
        cell.textLabel?.text = Localizable.List.Label.total
        cell.detailTextLabel?.text = "$0.00"

        return cell
    }()

    private let tableFooterView: UITableViewHeaderFooterView = UITableViewHeaderFooterView()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [tableView, tableFooterSeparatorView, tableFooterView])
        stackView.axis = .vertical

        return stackView
    }()

    // MARK: Variables

    weak var delegate: ListIncomeViewControllerDelegate?

    // MARK: Private variables

    private lazy var dataSource: EditingTableViewDataSource<DisplayIncomeList, Value1TableViewCell>? = {
        EditingTableViewDataSource<DisplayIncomeList, Value1TableViewCell>.make(
            for: [], then: { [weak self] (commit, indexPath) in
                self?.on(commit: commit, forRowAt: indexPath)
            }
        )
    }()

    // MARK: Private constants

    private let interactor: ListIncomeBusinessLogic

    // MARK: Initializer

    init(interactor: ListIncomeBusinessLogic) {
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

    // MARK: ListIncomeDisplayLogic conforms

    func displayFetchedIncomes(viewModel: ListIncome.FetchIncomes.ViewModel) {
        dataSource?.set(models: viewModel.displayedIncomes)
        tableFooterViewCell.detailTextLabel?.text = viewModel.total
        tableView.reloadData()
    }

    func displayDeletedIncome(viewModel: ListIncome.DeleteIncome.ViewModel) {
        dataSource?.set(models: viewModel.displayedIncomes)
        tableFooterViewCell.detailTextLabel?.text = viewModel.total
        tableView.deleteRows(at: [viewModel.deletedIndexPath], with: .automatic)
    }

    func displayDeletedIncomeError() {
    }

    // MARK: Private functions

    private func setupLayout() {
        view.addSubview(equalConstraintsFor: stackView)
        tableFooterSeparatorView.anchored().heightAnchor.constraint(equalToConstant: 1).isActive = true
        tableFooterView.anchored().heightAnchor.constraint(equalToConstant: 44).isActive = true
        tableFooterView.addSubview(equalConstraintsFor: tableFooterViewCell)
    }

    private func setupView() {
        title = Localizable.List.title
        view.backgroundColor = .white
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self, action: .onAddTapped
        )
    }

    private func on(commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let request = ListIncome.DeleteIncome.Request(style: editingStyle, indexPath: indexPath)

        interactor.editIncome(request: request)
    }

    // MARK: Fileprivate functions

    @objc
    fileprivate func onRightBarButtonTapped() {
        delegate?.listIncomeRightBarButtonItemTapped(self)
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
    static let onAddTapped = #selector(ListIncomeViewControler.onRightBarButtonTapped)
}
