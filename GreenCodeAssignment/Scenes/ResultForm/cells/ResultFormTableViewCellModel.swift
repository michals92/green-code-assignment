//
//  ResultFormTableViewCellModel.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 12.05.2022.
//

import Foundation

enum FormItemType {
    case text(String)
    case type(SportResultType)
    case duration(Double)
}

struct FormItem {
    let name: String
    let type: FormItemType
}

final class ResultFormTableViewCellModel {
    var formItem: FormItem
    var textFieldHandler: ((String) -> Void)?
    var durationFieldHandler: ((Double) -> Void)?

    init(formItem: FormItem) {
        self.formItem = formItem

        if case .duration = formItem.type {
            self.durationFieldHandler = { [weak self] value in
                self?.setLatestValue(value)
            }
        } else {
            self.textFieldHandler = { [weak self] value in
                self?.setLatestValue(value)
            }
        }
    }

    func setLatestValue(_ value: Double) {
        if case .duration = formItem.type {
            formItem = FormItem(name: formItem.name, type: .duration(value))
        } else {
            print("setLatestValue not implemented for \(formItem.name)!")
        }
    }

    func setLatestValue(_ value: String) {
        switch formItem.type {
        case .text:
            formItem = FormItem(name: formItem.name, type: .text(value))
        case .type:
            formItem = FormItem(name: formItem.name, type: .type(SportResultType(rawValue: value) ?? .local))
        default:
            print("setLatestValue not implemented for \(formItem.name)!")
        }
    }
}
