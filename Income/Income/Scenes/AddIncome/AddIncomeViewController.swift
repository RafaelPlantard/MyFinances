//
//  AddIncomeViewController.swift
//  Income
//
//  Created by Rafael Ferreira on 12/21/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

import UIKit

protocol AddIncomeDisplayLogic: AnyObject {
    func displayIncomeDate(viewModel: AddIncome.FormatDate.ViewModel)
    func displaySaveIncome(viewModel: AddIncome.ValidateNewIncome.ViewModel)
    func displayCreatedIncome()
    func displayError()
}

final class AddIncomeViewController: UIViewController, AddIncomeDisplayLogic {
    private let contentView: AddIncomeView = AddIncomeView()

    // MARK: Private constants

    private let interactor: AddIncomeBusinessLogic

    // MARK: Variables

    weak var delegate: AddIncomeViewControllerDelegate?

    // MARK: Initializer

    init(interactor: AddIncomeBusinessLogic) {
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
        setupNavigationBar()
        setupActions()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        contentView.focus()
    }

    // MARK: AddIncomePresentationLogic conforms

    func displayIncomeDate(viewModel: AddIncome.FormatDate.ViewModel) {
        contentView.update(date: viewModel.date)
    }

    func displaySaveIncome(viewModel: AddIncome.ValidateNewIncome.ViewModel) {
        navigationItem.rightBarButtonItem?.isEnabled = viewModel.isEnabled
    }

    func displayCreatedIncome() {
        delegate?.addIncomeRightBarButtonItemTapped(self)
    }

    func displayError() {
    }

    // MARK: Private functions

    private func setupActions() {
        contentView.bind { [weak interactor] (newDate: Date) in
            let request = AddIncome.FormatDate.Request(date: newDate)

            interactor?.formatIncomeDate(request: request)
        }

        contentView.bind { [weak interactor] (input: AddIncomeView.InputChanged) in
            let request = AddIncome.ValidateNewIncome.Request(
                incomeFormFields: AddIncome.IncomeFormFields(name: input.title, amount: input.amount, date: input.date)
            )

            interactor?.validateIncomeFields(request: request)
        }
    }

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
        let request = AddIncome.SaveNewIncome.Request(
            incomeFormFields: AddIncome.IncomeFormFields(
                name: contentView.title, amount: contentView.amount, date: contentView.date
            )
        )

        interactor.saveNewIncome(request: request)
    }
}

private extension Selector {
    static let onLeftBarButtonItemTapped = #selector(AddIncomeViewController.onLeftBarButtonItem)
    static let onRightBarButtonItemTapped = #selector(AddIncomeViewController.onRightBarButtonItem)
}
