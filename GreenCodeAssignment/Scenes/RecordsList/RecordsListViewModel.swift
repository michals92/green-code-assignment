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
    @Injected(\.networkProvider) var networkProvider: NetworkService

    private let coordinator: RecordsListCoordinatorInput
    private weak var viewController: RecordsListViewControllerInput?

    init(coordinator: RecordsListCoordinatorInput, viewController: RecordsListViewControllerInput) {
        self.coordinator = coordinator
        self.viewController = viewController
    }

    func viewDidLoad() {
        networkProvider.getResults { [weak self] result in
            switch result {
            case .success(let results):
                self?.viewController?.reloadData(results: results)
            case .failure(let error):
                print(error)
                // TODO: show error
            }
        }
    }

    func showResultForm() {
        coordinator.showResultForm()
    }
}
