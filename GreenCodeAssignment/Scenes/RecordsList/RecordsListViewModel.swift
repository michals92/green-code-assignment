//
//  RecordsListViewModel.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 10.05.2022.
//

import Foundation

protocol RecordsListViewControllerInput: AnyObject {
    func reloadData(cellModels: [RecordsListTableViewCellModel], type: RecordListType)
}

protocol RecordsListCoordinatorInput: AnyObject {
    func showResultForm()
    func showAlert(title: String, message: String, repeatHandler: @escaping Action)
}

protocol RecordsListViewModelInput: AnyObject {
    func viewDidLoad()
    func showResultForm()
    func getResults(for type: RecordListType)
    func getResultsForCurrentType()
}

final class RecordsListViewModel: RecordsListViewModelInput {
    @Injected(\.remoteResultService) var remoteResultService: ResultService
    @Injected(\.localResultService) var localResultService: LocalResultService

    private let coordinator: RecordsListCoordinatorInput
    private weak var viewController: RecordsListViewControllerInput?
    private var selectedType: RecordListType = .all

    init(coordinator: RecordsListCoordinatorInput, viewController: RecordsListViewControllerInput) {
        self.coordinator = coordinator
        self.viewController = viewController
    }

    func viewDidLoad() {
        getResults(for: .all)
    }

    func getResultsForCurrentType() {
        getResults(for: selectedType)
    }

    func getResults(for type: RecordListType) {
        selectedType = type
        switch selectedType {
        case .remote, .all:
            var allResults: [SportResult] = []

            if case .all = type {
                allResults = localResultService.getResults()
            }

            remoteResultService.getResults { [weak self] result in
                switch result {
                case .success(let remoteResults):
                    allResults.append(contentsOf: remoteResults)

                    let sortedResults = allResults.sorted {
                        $0.date > $1.date
                    }

                    self?.viewController?.reloadData(cellModels: sortedResults.map { RecordsListTableViewCellModel(sportResult: $0) }, type: type)
                case .failure(let error):
                    self?.coordinator.showAlert(
                        title: "error.title".localized,
                        message: error.description,
                        repeatHandler: { self?.getResults(for: type) }
                    )
                }
            }
        case .local:
            let sortedResults = localResultService.getResults().sorted {
                $0.date > $1.date
            }
            viewController?.reloadData(cellModels: sortedResults.map { RecordsListTableViewCellModel(sportResult: $0) }, type: type)
        }
    }

    func showResultForm() {
        coordinator.showResultForm()
    }
}
