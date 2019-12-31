//
//  ListYearViewController.swift
//  Calendar
//
//  Created by Rafael Ferreira on 12/31/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

import Core
import UIKit

final class ListYearViewController: UIViewController {
    private let segmentControl: UISegmentedControl = {
        let localizable = Localizable.Calendar.Segment.self
        let control = UISegmentedControl(items: [localizable.years, localizable.months, localizable.all])
        control.selectedSegmentIndex = 0

        return control
    }()

    override func loadView() {
        super.loadView()

        setupLayout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    // MARK: Private functions

    private func setupLayout() {
        view.addSubview(segmentControl, constraints: [
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            segmentControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }

    private func setupView() {
        title = Localizable.Calendar.title
    }
}
