//
//  AppDelegate.swift
//  notificationTest
//
//  Created by Jan on 01.06.24.
//

import UIKit
import Foundation
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    var timer: Timer?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }
    
    func toggleBackgroundTask() -> Bool{
        print("Toggle background task")
        if backgroundTask == .invalid {
            startBackgroundTask()
            return true
        } else {
            stopBackgroundTask()
            return false
        }
    }
        
    func startBackgroundTask() {
        print("Starting background task")
        //get the application
        let application = UIApplication.shared
        //if a background task was already started, ignore
        guard backgroundTask == .invalid else {
            print("Background task already started")
            return
        }
        // Start background task
        backgroundTask = application.beginBackgroundTask(withName: "BackgroundTask", expirationHandler: {
            application.endBackgroundTask(self.backgroundTask)
            self.backgroundTask = .invalid
            print("Background task expired")
        })
        
        // Schedule timer to write glucose value every minute
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            let glucoseValue = "\(Int.random(in: 40...400))"
            let data = ["glucose": glucoseValue, "timestamp": Date().timeIntervalSince1970, "trend": 1.5]
            GroupFileHandler.saveStringToGroupFile(string: "\(data)", fileName: "glucoseValues.txt", groupIdentifier: "group.kuq")
        }
    }
    func applicationWillTerminate(_ application: UIApplication) {
        stopBackgroundTask()
        print("Application will terminate")
    }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


extension AppDelegate {
    func stopBackgroundTask() {
        print("Stopping background task")
        timer?.invalidate()
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = .invalid
    }
}

