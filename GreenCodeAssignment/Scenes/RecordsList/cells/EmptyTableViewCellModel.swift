//
//  EmptyTableViewCellModel.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 13.05.2022.
//

import Foundation

final class EmptyTableViewCellModel {
    let title: String
    let buttonTitle: String

    var addRecordHandler: Action?

    init(title: String, buttonTitle: String, addRecordHandler: @escaping () -> Void) {
        self.title = title
        self.buttonTitle = buttonTitle
        self.addRecordHandler = addRecordHandler
    }
}
