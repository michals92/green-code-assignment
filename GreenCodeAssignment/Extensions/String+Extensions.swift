//
//  String+Extensions.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 11.05.2022.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
