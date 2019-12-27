//
//  IncomeCoreDataStore.swift
//  Income
//
//  Created by Rafael Ferreira on 12/25/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

import CoreData

final class IncomeCoreDataStore: IncomesStoreProtocol {
    private let container: NSPersistentContainer

    // MARK: Initializer

    init(container: NSPersistentContainer) {
        self.container = container
    }

    // MARK: IncomesStoreProtocol conforms

    func fetchIncomes(then handler: (Result<[Income], Error>) -> Void) {
        let request: NSFetchRequest<IncomeEntity> = IncomeEntity.fetchRequest()
        let context = container.viewContext

        do {
            let items = try context.fetch(request) as [IncomeEntity]

            handler(.success(items.map(Income.init)))
        } catch {
            handler(.failure(error))
        }
    }

    func save(income: Income, then handler: (Result<Void, Error>) -> Void) {
        do {
            let context = container.viewContext

            let entity = IncomeEntity(context: context)
            entity.id = income.id
            entity.amount = income.amount
            entity.createdOn = income.createdOn
            entity.date = income.date
            entity.name = income.name
            entity.updatedOn = income.updatedOn

            try context.save()

            handler(.success(()))
        } catch {
            handler(.failure(error))
        }
    }
}

private extension Income {
    init(entity: IncomeEntity) {
        self.init(
            id: entity.id, name: entity.name, amount: entity.amount, date: entity.date, createdOn: entity.createdOn,
            updatedOn: entity.updatedOn
        )
    }
}
