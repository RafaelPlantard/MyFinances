//
//  AddIncomeViewControllerDelegate.swift
//  Income
//
//  Created by Rafael Ferreira on 12/22/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

import UIKit

protocol AddIncomeViewControllerDelegate: AnyObject {
    func addIncomeLeftBarButtonItemTapped(_ viewController: AddIncomeViewController)
    func addIncomeRightBarButtonItemTapped(_ viewController: AddIncomeViewController)
}
