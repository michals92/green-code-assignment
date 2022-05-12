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

    init(formItem: FormItem) {
        self.formItem = formItem
        self.textFieldHandler = { value in self.setLatestValue(value) }
    }

    func setLatestValue(_ value: String) {
        switch formItem.type {
        case .text:
            formItem = FormItem(name: formItem.name, type: .text(value))
        case .type:
            formItem = FormItem(name: formItem.name, type: .type(SportResultType(rawValue: value) ?? .local))
        case .duration:
            formItem = FormItem(name: formItem.name, type: .duration(Double(value) ?? 0))
        }
    }
}
