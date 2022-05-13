//
//  ResultFormViewModel.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 10.05.2022.
//

import Foundation

protocol ResultFormViewControllerInput: AnyObject {
    func reloadData(cellModels: [ResultFormTableViewCellModel])
}

protocol ResultFormCoordinatorInput: AnyObject {
    func stop()
    func showAlert(title: String, message: String, repeatHandler: Action?)
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

    private var cellModels: [ResultFormTableViewCellModel] = []

    init(coordinator: ResultFormCoordinatorInput, viewController: ResultFormViewControllerInput) {
        self.coordinator = coordinator
        self.viewController = viewController
    }

    func viewDidLoad() {
        let array = [
            FormItem(name: "name", type: .text("")),
            FormItem(name: "place", type: .text("")),
            FormItem(name: "type", type: .type(.local)),
            FormItem(name: "duration", type: .duration(0))
        ]

        cellModels = array.map { ResultFormTableViewCellModel(formItem: $0) }
        viewController?.reloadData(cellModels: cellModels)
    }

    func cancel() {
        coordinator.stop()
    }

    func checkMandatoryFields(items: [String: Any]) -> Bool {
        let name = items["name"] as? String ?? ""
        let place = items["place"] as? String ?? ""
        let duration = items["duration"] as? Double ?? 0

        if name.isEmpty || place.isEmpty || duration == 0 {
            return false
        }
        return true
    }

    func confirm() {
        var values: [String: Any] = [:]

        for cellModel in cellModels {
            let type = cellModel.formItem.type
            let name = cellModel.formItem.name
            switch type {
            case .text(let value):
                values[name] = value
            case .type(let sportResultType):
                values[name] = sportResultType.rawValue
            case .duration(let value):
                values[name] = value
            }
        }

        guard checkMandatoryFields(items: values) else {
            coordinator.showAlert(title: "error.title".localized, message: "error.mandatoryFields".localized, repeatHandler: nil)
            return
        }

        let dateFormatter = ISO8601DateFormatter()
        values["date"] = dateFormatter.string(from: Date())

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: values)

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            let sportResult = try decoder.decode(SportResult.self, from: jsonData)

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
        } catch {
            coordinator.showAlert(title: "error.title".localized, message: "", repeatHandler: confirm)
        }
    }
}
