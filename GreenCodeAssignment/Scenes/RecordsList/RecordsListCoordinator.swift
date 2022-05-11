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
        guard let viewController = viewController else {
            fatalError("No controller to present on \(ResultFormCoordinator.self)")
        }
        
        let resultFormCoordinator = ResultFormCoordinator(previousController: viewController)
        resultFormCoordinator.start()
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
