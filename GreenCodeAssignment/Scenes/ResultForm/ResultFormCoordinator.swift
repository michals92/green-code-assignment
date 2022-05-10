//
//  ResultFormCoordinator.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 10.05.2022.
//

import UIKit

final class ResultFormCoordinator: Coordinator {
    private let navigationController: UINavigationController
    private weak var viewController: ResultFormViewController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = ResultFormViewController()
        let viewModel = ResultFormViewModel(coordinator: self, viewController: viewController)
        viewController.viewModel = viewModel
        self.viewController = viewController

        self.navigationController.present(viewController, animated: true)
    }

    func stop() {
        navigationController.popViewController(animated: true)
    }
}

extension ResultFormCoordinator: ResultFormCoordinatorInput {

}
