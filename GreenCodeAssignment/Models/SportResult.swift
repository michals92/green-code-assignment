//
//  SportResult.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 10.05.2022.
//

import Foundation

struct SportResult: Codable {
    let name: String
    let place: String
    let duration: Double
    let type: SportResultType
    let date: Date
}
