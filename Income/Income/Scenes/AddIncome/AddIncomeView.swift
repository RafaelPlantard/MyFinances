//
//  AddIncomeView.swift
//  Income
//
//  Created by Rafael Ferreira on 12/23/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

import Core
import UIKit

final class AddIncomeView: UIView, UITextFieldDelegate {
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Localizable.New.TextField.name
        textField.delegate = self

        return textField
    }()

    private let titleSeparatorView: UIView = UIView(backgroundColor: .separator)

    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()

        return datePicker
    }()

    private lazy var amountTextField: CurrencyTextField = {
        let textField = CurrencyTextField()
        textField.placeholder = Localizable.New.TextField.amount
        textField.delegate = self

        return textField
    }()

    private let amountSeparatorView: UIView = UIView(backgroundColor: .separator)

    private lazy var dateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Localizable.New.TextField.date
        textField.keyboardType = .numberPad
        textField.inputView = datePicker

        return textField
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleTextField, titleSeparatorView, amountTextField, amountSeparatorView, dateTextField
        ])

        stackView.axis = .vertical
        stackView.spacing = 16

        return stackView
    }()

    private lazy var orderOfFocus: [UIView] = [titleTextField, amountTextField, dateTextField]

    // MARK: Typealias

    typealias InputChanged = (title: String, amount: Double, date: Date)

    // MARK: Computed variables

    var title: String {
        return titleTextField.text.or(.empty)
    }

    var amount: Double {
        return amountTextField.value
    }

    var date: Date {
        return datePicker.date
    }

    // MARK: Private variables

    private var dateChanged: ((Date) -> Void)?
    private var inputChanged: ((InputChanged) -> Void)?

    // MARK: Initializer

    init() {
        super.init(frame: .zero)

        setupLayout()
        setupActions()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupLayout()
        setupActions()
    }

    // MARK: Functions

    func bind(action: @escaping (Date) -> Void) {
        dateChanged = action
        didDatePickerChanged()
    }

    func bind(action: @escaping (InputChanged) -> Void) {
        inputChanged = action
        didInputFieldChanged()
    }

    func update(date: String) {
        dateTextField.text = date
    }

    func focus() {
        titleTextField.becomeFirstResponder()
    }

    // MARK: UITextFieldDelegate conforms

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let currentIndex = orderOfFocus.enumerated().first(where: { (_, element) in element == textField })
            .map({ index, _ in index }).or(0)

        orderOfFocus[currentIndex + 1].becomeFirstResponder()

        return false
    }

    // MARK: Private functions

    private func setupActions() {
        datePicker.addTarget(self, action: .onDatePickerChanged, for: .valueChanged)
        titleTextField.addTarget(self, action: .onInputFieldChanged, for: .editingChanged)
        amountTextField.addTarget(self, action: .onInputFieldChanged, for: .editingChanged)
        dateTextField.addTarget(self, action: .onInputFieldChanged, for: .editingChanged)
    }

    private func setupLayout() {
        addSubview(equalConstraintsFor: stackView)

        titleSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        amountSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }

    // MARK: Fileprivate functions

    @objc
    fileprivate func didInputFieldChanged() {
        inputChanged?((title: title, amount: amount, date: date))
    }

    @objc
    fileprivate func didDatePickerChanged() {
        dateChanged?(datePicker.date)
    }
}

private extension Selector {
    static let onDatePickerChanged = #selector(AddIncomeView.didDatePickerChanged)
    static let onInputFieldChanged = #selector(AddIncomeView.didInputFieldChanged)
}
