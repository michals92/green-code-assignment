//
//  ResultFormCoordinator.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 10.05.2022.
//

import UIKit

typealias Action = () -> Void

final class ResultFormCoordinator: Coordinator {
    private let previousController: UIViewController
    private weak var navigationController: UINavigationController?
    private weak var viewController: ResultFormViewController?

    let completionAction: Action?

    init(previousController: UIViewController, completionAction: Action?) {
        self.previousController = previousController
        self.completionAction = completionAction
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
        completionAction?()
        previousController.dismiss(animated: true)
    }
}

extension ResultFormCoordinator: ResultFormCoordinatorInput {
    func showAlert(title: String, message: String, repeatHandler: Action?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        if let repeatHandler = repeatHandler {
            let repeatAction = UIAlertAction(title: "alert.repeat".localized, style: .default) { _ in
                repeatHandler()
            }
            alert.addAction(repeatAction)
        }
        let cancelAction = UIAlertAction(title: "alert.ok".localized, style: .cancel)
        alert.addAction(cancelAction)
        viewController?.present(alert, animated: true)
    }
}
