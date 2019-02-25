//
//  AppDelegate.swift
//  memoji
//
//  Created by CAU on 07/02/2019.
//  Copyright © 2019 purplxider. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if UserDefaults.standard.object(forKey: "money") == nil {
            UserDefaults.standard.set(0, forKey: "money")
        }
        if UserDefaults.standard.object(forKey: "questionNumber") == nil {
            UserDefaults.standard.set(1, forKey: "questionNumber")
        }
        if UserDefaults.standard.object(forKey: "kpop") == nil {
            var questions = [Question]()
            questions.append(Question(emoji: "🔁🤝🌏", length: 6, answer: ["다", "시", "만", "난", "세", "계"]))
            let data = NSKeyedArchiver.archivedData(withRootObject: questions)
            UserDefaults.standard.set(data, forKey: "kpop")
        }
        if UserDefaults.standard.object(forKey: "drama") == nil {
            var questions = [Question]()
            questions.append(Question(emoji: "🔁🤝2", length: 3, answer: ["다", "시", "만"]))
            let data = NSKeyedArchiver.archivedData(withRootObject: questions)
            UserDefaults.standard.set(data, forKey: "drama")
        }
        if UserDefaults.standard.object(forKey: "movie") == nil {
            var questions = [Question]()
            questions.append(Question(emoji: "🔁🤝3", length: 4, answer: ["다", "시", "만", "난"]))
            let data = NSKeyedArchiver.archivedData(withRootObject: questions)
            UserDefaults.standard.set(data, forKey: "movie")
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

