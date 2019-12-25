//
//  AddIncomeView.swift
//  Income
//
//  Created by Rafael Ferreira on 12/23/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

import UIKit

final class AddIncomeView: UIView {
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Localizable.New.TextField.name

        return textField
    }()

    private let separatorView: UIView = UIView(backgroundColor: .separator)

    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()

        return datePicker
    }()

    private lazy var dateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Localizable.New.TextField.date
        textField.keyboardType = .numberPad
        textField.inputView = datePicker

        return textField
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleTextField, separatorView, dateTextField])
        stackView.axis = .vertical
        stackView.spacing = 16

        return stackView
    }()

    // MARK: Private variables

    private var dateChanged: ((Date) -> ())?

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

    func bind(action: @escaping (Date) -> ()) {
        dateChanged = action
        didDatePickerChanged()
    }

    func update(date: String) {
        dateTextField.text = date
    }

    // MARK: Private functions

    private func setupActions() {
        datePicker.addTarget(self, action: .onDatePickerChanged, for: .valueChanged)
    }

    private func setupLayout() {
        addSubview(equalConstraintsFor: stackView)

        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }

    // MARK: Fileprivate functions

    @objc
    fileprivate func didDatePickerChanged() {
        dateChanged?(datePicker.date)
    }
}

private extension Selector {
    static let onDatePickerChanged = #selector(AddIncomeView.didDatePickerChanged)
}
