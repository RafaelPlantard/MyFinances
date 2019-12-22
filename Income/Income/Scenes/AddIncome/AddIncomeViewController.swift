//
//  AddIncomeViewController.swift
//  Income
//
//  Created by Rafael Ferreira on 12/21/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

import UIKit

final class AddIncomeViewController: UIViewController {
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Localizable.New.TextField.name

        return textField
    }()

    private let separatorView: UIView = UIView(backgroundColor: .separator)

    private let dateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Localizable.New.TextField.date
        textField.keyboardType = .numberPad

        return textField
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleTextField, separatorView, dateTextField])
        stackView.axis = .vertical
        stackView.spacing = 16

        return stackView
    }()

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
        view.addSubview(stackView, constraints: [
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
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
