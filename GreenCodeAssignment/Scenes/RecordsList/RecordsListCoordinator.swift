//
//  RecordsListCoordinator.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 10.05.2022.
//

import UIKit

final class RecordsListCoordinator: Coordinator {
    private var navigationController: UINavigationController?
    private weak var viewController: RecordsListViewController?

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let viewController = RecordsListViewController()
        let viewModel = RecordsListViewModel(coordinator: self, viewController: viewController)
        viewController.viewModel = viewModel
        self.viewController = viewController
        self.navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
    }
}

extension RecordsListCoordinator: RecordsListCoordinatorInput {
    func showResultForm() {
        guard let navigationController = navigationController else {
            fatalError("no navigation controller to present \(ResultFormCoordinator.self)")
        }
        
        let resultFormCoordinator = ResultFormCoordinator(navigationController: navigationController)
        resultFormCoordinator.start()
    }
}
