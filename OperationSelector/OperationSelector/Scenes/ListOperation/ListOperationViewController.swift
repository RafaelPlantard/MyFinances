//
//  ListOperationViewController.swift
//  OperationSelector
//
//  Created by Rafael Ferreira on 1/3/20.
//  Copyright © 2020 Swift Yah. All rights reserved.
//

import UIKit

final class ListOperationViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView() {
        title = Localizable.List.title
        view.backgroundColor = .white
    }
}
