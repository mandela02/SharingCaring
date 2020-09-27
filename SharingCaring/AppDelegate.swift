//
//  AppDelegate.swift
//  SharingCaring
//
//  Created by TriBQ on 9/20/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let homeViewController = HomeViewController.instantiateFromStoryboard()
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        window?.rootViewController = homeNavigationController
        window?.makeKeyAndVisible()
        return true
    }
}
