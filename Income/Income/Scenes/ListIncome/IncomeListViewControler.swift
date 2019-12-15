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

    // MARK: Override functions

    override func loadView() {
        super.loadView()

        setupLayout()
    }

    // MARK: Private functions

    private func setupLayout() {
        view.addSubview(equalConstraintsFor: tableView)
    }
}
