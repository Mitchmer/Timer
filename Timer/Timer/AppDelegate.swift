//
//  AppDelegate.swift
//  Timer
//
//  Created by Mitch Merrell on 8/6/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            if let error = error { print(error.localizedDescription)}
            
            if success {
                print("permission granted")
            }
        }
        
        return true
        
    }

    

}

