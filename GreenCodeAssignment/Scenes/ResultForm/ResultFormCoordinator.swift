//
//  ResultFormCoordinator.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 10.05.2022.
//

import UIKit

final class ResultFormCoordinator: Coordinator {
    private var navigationController: UINavigationController?
    private weak var viewController: ResultFormViewController?

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let viewController = ResultFormViewController()
        let viewModel = ResultFormViewModel(coordinator: self, viewController: viewController)
        viewController.viewModel = viewModel
        self.viewController = viewController
        self.navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
    }
}

extension ResultFormCoordinator: ResultFormCoordinatorInput {

}
