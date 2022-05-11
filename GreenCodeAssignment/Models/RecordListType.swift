//
//  RecordListType.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 11.05.2022.
//

import Foundation

enum RecordListType: Int, CaseIterable {
    case all
    case remote
    case local

    func title() -> String {
        switch self {
        case .all:
            return "RecordListType.all".localized
        case .remote:
            return "RecordListType.remote".localized
        case .local:
            return "RecordListType.local".localized
        }
    }
}
