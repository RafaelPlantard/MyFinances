//
//  AddIncomeViewController.swift
//  Income
//
//  Created by Rafael Ferreira on 12/21/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

import UIKit

final class AddIncomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView() {
        title = Localizable.New.title
        view.backgroundColor = .white
    }
}
