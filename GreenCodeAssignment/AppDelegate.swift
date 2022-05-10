//
//  AppDelegate.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 10.05.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let appCoordinator = AppCoordinator()
        appCoordinator.start()
        
        return true
    }
}
