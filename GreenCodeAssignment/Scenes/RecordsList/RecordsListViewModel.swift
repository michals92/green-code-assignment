//
//  RecordsListViewModel.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 10.05.2022.
//

import Foundation

protocol RecordsListViewControllerInput: AnyObject {
    func reloadData(results: [SportResult])
}

protocol RecordsListCoordinatorInput: AnyObject {
    func showResultForm()
}

protocol RecordsListViewModelInput: AnyObject {
    func viewDidLoad()
    func showResultForm()
}

final class RecordsListViewModel: RecordsListViewModelInput {
    @Injected(\.networkProvider) var networkProvider: NetworkProviding

    private let coordinator: RecordsListCoordinatorInput
    private weak var viewController: RecordsListViewControllerInput?

    init(coordinator: RecordsListCoordinatorInput, viewController: RecordsListViewControllerInput) {
        self.coordinator = coordinator
        self.viewController = viewController
    }

    func viewDidLoad() {
        networkProvider.requestData()

        let mockResults = [
            SportResult(name: "test", place: "test place", duration: 21, type: .local),
            SportResult(name: "test 1", place: "test place 2", duration: 21, type: .local)
        ]
        viewController?.reloadData(results: mockResults)
    }

    func showResultForm() {
        coordinator.showResultForm()
    }
}
