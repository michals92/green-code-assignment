//
//  FirebaseResultService.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 11.05.2022.
//

import UIKit
import FirebaseFirestore

struct FirebaseResultService: ResultService {
    let collection = Firestore.firestore().collection("sport-results-\(UIDevice.current.identifierForVendor?.uuidString ?? "default")")

    func getResults(completion: @escaping (Result<[SportResult], ResultError>) -> Void) {
        collection.getDocuments { snapshot, _ in
            guard let snapshot = snapshot else {
                DispatchQueue.main.async {
                    completion(.failure(.snapshot))
                }
                return
            }

            do {
                let results = try snapshot.documents.compactMap { (document) -> SportResult in
                    let jsonData = try JSONSerialization.data(withJSONObject: document.data())

                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let result = try decoder.decode(SportResult.self, from: jsonData)
                    return result
                }
                DispatchQueue.main.async {
                    completion(.success(results))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.parsing))
                }
            }
        }
    }

    func addResult(_ result: SportResult, completion: @escaping (Result<Void, ResultError>) -> Void) {
        do {
            let jsonData = try result.jsonData()
            let json = try JSONSerialization.jsonObject(with: jsonData, options: [])

            guard let dictionary = json as? [String: Any] else {
                completion(.failure(.parsing))
                return
            }

            collection.addDocument(data: dictionary) { error in
                DispatchQueue.main.async {
                    completion(error != nil ? .failure(.snapshot) : .success(()))
                }
            }
        } catch {
            completion(.failure(.parsing))
        }
    }
}
