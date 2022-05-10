//
//  AppCoordinator.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 10.05.2022.
//

import UIKit

final class AppCoordinator: Coordinator {
    private let window: UIWindow

    init() {
        window = UIWindow()
        window.makeKeyAndVisible()
    }

    func start() {
        let recordsListCoordinator = RecordsListCoordinator(window: window)
        recordsListCoordinator.start()
    }
}
