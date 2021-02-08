//
//  AppDelegate.swift
//  Venus
//
//  Created by Victoria Fargutu on 08.02.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: VenuesViewController())
        window?.makeKeyAndVisible()
        return true
    }
}

