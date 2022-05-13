//
//  LocalResultService.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 11.05.2022.
//

import Foundation

struct LocalResultService {
    func getResults() -> [SportResult] {
        UserDefaults.localSportResults
    }

    func addResult(_ result: SportResult) {
        UserDefaults.localSportResults.append(result)
    }
}
