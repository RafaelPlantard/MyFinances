//
//  TableViewDataSource.swift
//  Core
//
//  Created by Rafael Ferreira on 12/26/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

import UIKit

public final class TableViewDataSource<Model>: NSObject, UITableViewDataSource {
    public typealias CellConfigurator = (Model, UITableViewCell) -> Void

    // MARK: Read-only variables

    private(set) var models: [Model]

    // MARK: Private constants

    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator

    // MARK: Initializers

    public init(models: [Model], reuseIdentifier: String, cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }

    // MARK: UITableViewDataSource conforms

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        cellConfigurator(model, cell)

        return cell
    }
}
