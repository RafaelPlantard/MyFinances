//
//  IncomeViewController.swift
//  Income
//
//  Created by Rafael Ferreira on 12/15/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

import Core
import UIKit

final class IncomeListViewControler: UIViewController {
    private let tableView: UITableView = UITableView()

    // MARK: Variables

    weak var delegate: IncomeListViewControllerDelegate?

    // MARK: Override functions

    override func loadView() {
        super.loadView()

        setupLayout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupNavigationBar()
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
            barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: .onAddTapped
        )
    }

    // MARK: Fileprivate functions

    @objc
    fileprivate func onRightBarButtonTapped() {
        delegate?.incomeListRightBarButtonItemTapped(self)
    }
}

private extension Selector {
    static let onAddTapped = #selector(IncomeListViewControler.onRightBarButtonTapped)
}
