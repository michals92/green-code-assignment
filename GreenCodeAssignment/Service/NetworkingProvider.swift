//
//  NetworkingProvider.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 10.05.2022.
//

import Foundation

protocol NetworkProviding {
    func requestData()
}

struct NetworkProvider: NetworkProviding {
    func requestData() {
        print("Data requested using the `NetworkProvider`")
    }
}
