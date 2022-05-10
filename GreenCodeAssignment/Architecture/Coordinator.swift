//
//  Coordinator.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 10.05.2022.
//

import Foundation

protocol Coordinator {
    func start()
    func stop()
}

extension Coordinator {
    func stop() {}
}
