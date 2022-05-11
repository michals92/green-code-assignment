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
        coordinator.stop()
    }
}
