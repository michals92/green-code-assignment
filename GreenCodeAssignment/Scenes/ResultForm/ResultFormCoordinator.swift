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

    func showAlert(title: String, message: String, repeatHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let repeatAction = UIAlertAction(title: "alert.repeat".localized, style: .default) { _ in
            repeatHandler()
        }
        let cancelAction = UIAlertAction(title: "alert.cancel".localized, style: .cancel)
        alert.addAction(repeatAction)
        alert.addAction(cancelAction)

        viewController?.present(alert, animated: true)
    }
}

extension ResultFormCoordinator: ResultFormCoordinatorInput {

}
