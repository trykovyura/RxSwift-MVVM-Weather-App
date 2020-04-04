//
//  AppDelegate.swift
//  weather
//
//  Created by Юрий Трыков on 24.08.17.
//  Copyright © 2017 trykov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow()
    let appCoordinator = AppCoordinator()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appCoordinator.start(window: window)
        return true
    }
}
