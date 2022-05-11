//
//  ResultService.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 10.05.2022.
//

import Foundation

enum ResultError: Error {
    case snapshot
    case parsing

    var description: String {
        switch self {
        case .snapshot:
            return "ResultError.snapshot".localized
        case .parsing:
            return "ResultError.parsing".localized
        }
    }
}

protocol ResultService {
    func getResults(completion: @escaping (Result<[SportResult], ResultError>) -> Void)
    func addResult(_ result: SportResult, completion: @escaping (Result<Void, ResultError>) -> Void)
}
