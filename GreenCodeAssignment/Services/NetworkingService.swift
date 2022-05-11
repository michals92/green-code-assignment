//
//  NetworkingProvider.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 10.05.2022.
//

import Foundation
import FirebaseFirestore

protocol NetworkService {
    func getResults(completion: @escaping (Result<[SportResult], NetworkError>) -> Void)
    func addResult(_ result: SportResult, completion: @escaping (Result<Void, NetworkError>) -> Void)
}

enum NetworkError: Error {
    case snapshot
    case parsing
}

struct FirebaseNetworkService: NetworkService {
    let collection = Firestore.firestore().collection("sport-results")

    func getResults(completion: @escaping (Result<[SportResult], NetworkError>) -> Void) {
        collection.getDocuments { snapshot, _ in
            guard let snapshot = snapshot else {
                completion(.failure(.snapshot))
                return
            }

            do {
                let results = try snapshot.documents.compactMap { (document) -> SportResult in
                    let jsonData = try JSONSerialization.data(withJSONObject: document.data())
                    let result = try JSONDecoder().decode(SportResult.self, from: jsonData)
                    return result
                }
                completion(.success(results))
            } catch {
                completion(.failure(.parsing))
            }
        }
    }

    func addResult(_ result: SportResult, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        do {
            let jsonData = try result.jsonData()
            let json = try JSONSerialization.jsonObject(with: jsonData, options: [])

            guard let dictionary = json as? [String: Any] else {
                completion(.failure(.parsing))
                return
            }

            collection.addDocument(data: dictionary) { error in
                completion(error != nil ? .failure(.snapshot) : .success(()))
            }
        } catch {
            completion(.failure(.parsing))
        }
    }
}
