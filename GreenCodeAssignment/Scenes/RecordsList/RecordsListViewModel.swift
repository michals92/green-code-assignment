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
    func getResults(for type: RecordListType)
}

final class RecordsListViewModel: RecordsListViewModelInput {
    @Injected(\.remoteResultService) var remoteResultService: ResultService
    @Injected(\.localResultService) var localResultService: LocalResultService

    private let coordinator: RecordsListCoordinatorInput
    private weak var viewController: RecordsListViewControllerInput?

    init(coordinator: RecordsListCoordinatorInput, viewController: RecordsListViewControllerInput) {
        self.coordinator = coordinator
        self.viewController = viewController
    }

    func viewDidLoad() {
        getResults(for: .all)
    }

    func getResults(for type: RecordListType) {
        switch type {
        case .remote, .all:
            var allResults: [SportResult] = []

            if case .all = type {
                allResults = localResultService.getResults()
            }

            remoteResultService.getResults { [weak self] result in
                switch result {
                case .success(let remoteResults):
                    allResults.append(contentsOf: remoteResults)
                    self?.viewController?.reloadData(results: allResults)
                case .failure(let error):
                    print(error)
                    // TODO: show error
                }
            }
        case .local:
            viewController?.reloadData(results: localResultService.getResults())
        }
    }


    func showResultForm() {
        coordinator.showResultForm()
    }
}
