//
//  AppDelegate.swift
//  AnalogClock
//
//  Created by Jiwon Nam on 4/24/21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.rootViewController = ClockViewController()
        window?.makeKeyAndVisible()
        
        return true
    }

}

