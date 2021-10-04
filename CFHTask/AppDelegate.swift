//
//  AppDelegate.swift
//  CFHTask
//
//  Created by fox on 2021/7/28.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow()
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = HomeViewController()
        if #available(iOS 13.0, *) {
            self.window?.overrideUserInterfaceStyle = .light
        }
        
        return true
    }
}

