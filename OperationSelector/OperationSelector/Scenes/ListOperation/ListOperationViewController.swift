//
//  ListOperationViewController.swift
//  OperationSelector
//
//  Created by Rafael Ferreira on 1/3/20.
//  Copyright © 2020 Swift Yah. All rights reserved.
//

import Core
import UIKit

protocol ListOperationDisplayLogic: AnyObject {
    func displayFetchedOperations(viewModel: ListOperation.FetchOperations.ViewModel)
    func displayIncomeOperation()
}

final class ListOperationViewController: UIViewController, ListOperationDisplayLogic {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self)
        tableView.dataSource = dataSource
        tableView.delegate = tableViewDelegate

        return tableView
    }()

    // MARK: Private lazy variables

    private lazy var tableViewDelegate: UITableViewDelegate = {
        TableViewDelegate { [weak self] indexPath in
            self?.onTapped(indexPath: indexPath)
        }
    }()

    // MARK: Variables

    weak var delegate: ListOperationViewControllerDelegate?

    // MARK: Private constants

    private let interactor: ListOperationBusinessLogic

    private let dataSource: DataSource & UITableViewDataSource = {
        TableViewDataSource<String, UITableViewCell>(models: []) { (model, cell) in
            cell.textLabel?.text = model
        }
    }()

    // MARK: Initializers

    init(interactor: ListOperationBusinessLogic) {
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

    // MARK: ListOperationDisplayLogic conforms

    func displayFetchedOperations(viewModel: ListOperation.FetchOperations.ViewModel) {
        dataSource.set(models: viewModel.operations)
        tableView.reloadData()
    }

    func displayIncomeOperation() {
        delegate?.listOperationDidSelectIncomeOperation(self)
    }

    // MARK: Private functions

    private func fetch() {
        interactor.fetchOperations()
    }

    private func setupLayout() {
        view.addSubview(equalConstraintsFor: tableView)
    }

    private func setupView() {
        title = Localizable.List.title
        view.backgroundColor = .white
    }

    private func onTapped(indexPath: IndexPath) {
        let request = ListOperation.SelectOperation.Request(indexPath: indexPath)

        interactor.selectOperation(request: request)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
