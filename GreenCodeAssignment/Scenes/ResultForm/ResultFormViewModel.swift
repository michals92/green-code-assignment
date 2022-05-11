//
//  ResultFormViewModel.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 10.05.2022.
//

import Foundation

protocol ResultFormViewControllerInput: AnyObject {

}

protocol ResultFormCoordinatorInput: AnyObject {
    func stop()
    func showAlert(title: String, message: String, repeatHandler: @escaping () -> Void)
}

protocol ResultFormViewModelInput: AnyObject {
    func viewDidLoad()
    func cancel()
    func confirm()
}

final class ResultFormViewModel: ResultFormViewModelInput {
    @Injected(\.remoteResultService) var remoteResultService: ResultService
    @Injected(\.localResultService) var localResultService: LocalResultService

    private let coordinator: ResultFormCoordinatorInput
    private weak var viewController: ResultFormViewControllerInput?

    init(coordinator: ResultFormCoordinatorInput, viewController: ResultFormViewControllerInput) {
        self.coordinator = coordinator
        self.viewController = viewController
    }

    func viewDidLoad() {

    }

    func cancel() {
        coordinator.stop()
    }

    func confirm() {
        let sportResult = SportResult(name: "Běh", place: "Brno", duration: 20, type: .remote)

        switch sportResult.type {
        case .remote:
            remoteResultService.addResult(sportResult) { [weak self] result in
                switch result {
                case .success:
                    self?.coordinator.stop()
                case .failure(let error):
                    self?.coordinator.showAlert(
                        title: "error.title".localized,
                        message: error.description,
                        repeatHandler: { self?.confirm() }
                    )
                }
            }
        case .local:
            localResultService.addResult(sportResult)
            coordinator.stop()
        }
    }
}
