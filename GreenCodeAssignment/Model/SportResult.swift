//
//  SportResult.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 10.05.2022.
//

import Foundation

enum SportResultType: String, Decodable {
    case local
    case remote
}

struct SportResult: Decodable {
    let name: String
    let place: String
    let duration: Double
    let type: SportResultType
}
