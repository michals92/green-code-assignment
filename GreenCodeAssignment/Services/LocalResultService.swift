//
//  LocalResultService.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 11.05.2022.
//

import Foundation

struct LocalResultService: ResultService {
    func getResults(completion: @escaping (Result<[SportResult], ResultError>) -> Void) {
        completion(.success(UserDefaults.localSportResults))
    }

    func addResult(_ result: SportResult, completion: @escaping (Result<Void, ResultError>) -> Void) {
        UserDefaults.localSportResults.append(result)
        completion(.success(()))
    }
}
