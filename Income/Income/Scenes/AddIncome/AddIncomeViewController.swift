//
//  AddIncomeViewController.swift
//  Income
//
//  Created by Rafael Ferreira on 12/21/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

import UIKit

final class AddIncomeViewController: UIViewController {
    private let contentView: UIView = AddIncomeView()

    // MARK: Variables

    weak var delegate: AddIncomeViewControllerDelegate?

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
        view.addSubview(contentView, constraints: [
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: Localizable.New.Button.cancel, style: .plain, target: self, action: .onLeftBarButtonItemTapped
        )

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: Localizable.New.Button.done, style: .done, target: self, action: .onRightBarButtonItemTapped
        )
    }

    private func setupView() {
        title = Localizable.New.title
        view.backgroundColor = .white
    }

    // MARK: Fileprivate functions

    @objc
    fileprivate func onLeftBarButtonItem() {
        delegate?.addIncomeLeftBarButtonItemTapped(self)
    }

    @objc
    fileprivate func onRightBarButtonItem() {
        delegate?.addIncomeRightBarButtonItemTapped(self)
    }
}

private extension Selector {
    static let onLeftBarButtonItemTapped = #selector(AddIncomeViewController.onLeftBarButtonItem)
    static let onRightBarButtonItemTapped = #selector(AddIncomeViewController.onRightBarButtonItem)
}
