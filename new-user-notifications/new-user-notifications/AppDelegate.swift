//
//  AppDelegate.swift
//  new-user-notifications
//
//  Created by 程庆春 on 2017/1/2.
//  Copyright © 2017年 Qiun Cheng. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override pointfor customization after application launch.

        UNUserNotificationCenter.current().delegate = self

        UNUserNotificationCenter.current().requestAuthorization(options: [UNAuthorizationOptions.sound, UNAuthorizationOptions.alert]) { (granted, error) in
            if granted {
                print("Approval granted to send notifications")
            }
        }

        self.addCategory()

        return true
    }

    func addCategory() {
        // Add action
        let cancelAction = UNNotificationAction(identifier: Identifiers.cancelAction,
                                                title: "Cancel",
                                                options: [.foreground])

        // Create category
        let category = UNNotificationCategory(identifier: Identifiers.reminderCategory,
                                              actions: [cancelAction],
                                              intentIdentifiers: [],
                                              options: [])

        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
}
extension AppDelegate: UNUserNotificationCenterDelegate {

    // Note: Don't use autocomplete for this -> copy from generated interface instead
    public func userNotificationCenter(_ center: UNUserNotificationCenter,
                                       didReceive response: UNNotificationResponse,
                                       withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == Identifiers.cancelAction {
            let request = response.notification.request
            print("Removing item with identifier \(request.identifier)")
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [request.identifier])
        }

        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // New in iOS 10, we can show notifications when app is in foreground, by calling completion handler with our desired presentation type.
        completionHandler([.alert, .badge])
    }
}
