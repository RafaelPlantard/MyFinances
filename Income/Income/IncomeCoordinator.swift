//
//  IncomeCoordinator.swift
//  Income
//
//  Created by Rafael Ferreira on 12/15/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

import Core
import CoreData
import UIKit

public final class IncomeCoordinator: Coordinator, ListIncomeViewControllerDelegate, AddIncomeViewControllerDelegate {
    private let navigationController: UINavigationController

    // MARK: Private variables

    private var rootViewControler: ListIncomeViewControler?

    // MARK: Private lazy variables

    private lazy var persistentContainer: NSPersistentContainer = {
        let container: NSPersistentContainer

        if let modelURL = Bundle(for: IncomeCoordinator.self).url(forResource: "Incomes", withExtension: "momd"),
            let model = NSManagedObjectModel(contentsOf: modelURL) {
            container = NSPersistentContainer(name: "Incomes", managedObjectModel: model)
        } else {
            container = NSPersistentContainer(name: "Incomes")
        }

        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }

        return container
    }()

    // MARK: Initializer

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: Coordinator conforms

    public func start() {
        let store = IncomeCoreDataStore(container: persistentContainer)
        let presenter = ListIncomePresenter()
        let interactor = ListIncomeInteractor(store: store, presenter: presenter)
        let listIncomeViewController = ListIncomeViewControler(interactor: interactor)
        presenter.viewController = listIncomeViewController
        listIncomeViewController.delegate = self

        rootViewControler = listIncomeViewController
        navigationController.pushViewController(listIncomeViewController, animated: true)
    }

    // MARK: ListIncomeViewControllerDelegate conforms

    func listIncomeRightBarButtonItemTapped(_ viewController: ListIncomeViewControler) {
        let presenter = AddIncomePresenter()
        let store = IncomeCoreDataStore(container: persistentContainer)
        let interactor = AddIncomeInteractor(store: store, presenter: presenter)
        let addIncomeViewController = AddIncomeViewController(interactor: interactor)
        presenter.viewController = addIncomeViewController
        addIncomeViewController.delegate = self

        let newNavigationController = UINavigationController(rootViewController: addIncomeViewController)
        newNavigationController.modalPresentationCapturesStatusBarAppearance = true

        navigationController.present(newNavigationController, animated: true, completion: nil)
    }

    // MARK: AddIncomeViewControllerDelegate conforms

    func addIncomeLeftBarButtonItemTapped(_ viewController: AddIncomeViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }

    func addIncomeRightBarButtonItemTapped(_ viewController: AddIncomeViewController) {
        viewController.dismiss(animated: true) { [weak self] in
            self?.rootViewControler?.fetch()
        }
    }
}
