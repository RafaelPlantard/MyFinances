//
//  Income.swift
//  Income
//
//  Created by Rafael Ferreira on 12/27/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

struct Income {
    let id: UUID
    let name: String
    let amount: Double
    let date: Date
    let createdOn: Date
    let updatedOn: Date

    // MARK: Initializers

    init(id: UUID, name: String, amount: Double, date: Date, createdOn: Date, updatedOn: Date) {
        self.id = id
        self.name = name
        self.amount = amount
        self.date = date
        self.createdOn = createdOn
        self.updatedOn = updatedOn
    }

    init(name: String, amount: Double, date: Date) {
        self.id = UUID()
        self.name = name
        self.amount = amount
        self.date = date
        self.createdOn = Date()
        self.updatedOn = Date()
    }
}
