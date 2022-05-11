//
//  ResultFormCoordinator.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 10.05.2022.
//

import UIKit

final class ResultFormCoordinator: Coordinator {
    private let previousController: UIViewController
    private weak var navigationController: UINavigationController?
    private weak var viewController: ResultFormViewController?

    init(previousController: UIViewController) {
        self.previousController = previousController
    }

    func start() {
        let viewController = ResultFormViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        let viewModel = ResultFormViewModel(coordinator: self, viewController: viewController)
        viewController.viewModel = viewModel
        self.viewController = viewController
        self.navigationController = navigationController

        self.previousController.present(navigationController, animated: true)
    }

    func stop() {
        previousController.dismiss(animated: true)
    }
}

extension ResultFormCoordinator: ResultFormCoordinatorInput {

}
