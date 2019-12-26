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
        let request: NSFetchRequest<Income> = Income.fetchRequest()
        let context = container.viewContext

        do {
            let items = try context.fetch(request) as [Income]

            handler(.success(items))
        } catch {
            handler(.failure(error))
        }
    }
}
