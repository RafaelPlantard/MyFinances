//
//  ListYearViewControllerDelegate.swift
//  Calendar
//
//  Created by Rafael Ferreira on 1/3/20.
//  Copyright © 2020 Swift Yah. All rights reserved.
//

protocol ListYearViewControllerDelegate: AnyObject {
    func listYearMonthTapped(date: Date, _ viewController: ListYearViewController)
    func listYearRightBarButtonItemTapped(date: Date, _ viewController: ListYearViewController)
}
