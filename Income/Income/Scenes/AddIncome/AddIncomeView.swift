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

    // MARK: Initializer

    init() {
        super.init(frame: .zero)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupLayout()
    }

    // MARK: Private functions

    private func setupLayout() {
        addSubview(equalConstraintsFor: stackView)

        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}
