//
//  CalendarCoordinatorDelegate.swift
//  Calendar
//
//  Created by Rafael Ferreira on 1/3/20.
//  Copyright © 2020 Swift Yah. All rights reserved.
//

public protocol CalendarCoordinatorDelegate: AnyObject {
    func calendarCoordinatorDidFinish(with date: Date, _ coordinator: CalendarCoordinator)
}
