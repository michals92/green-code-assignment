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

}

protocol RecordsListViewModelInput: AnyObject {
    func viewDidLoad()
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
    }
}
