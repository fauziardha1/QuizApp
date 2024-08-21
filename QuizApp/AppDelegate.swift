//
//  AppDelegate.swift
//  QuizApp
//
//  Created by FauziArda on 13/08/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
        let tempQuestion: String = "A question"
        let tempOptions: [String] = ["Option 1","Option 2"]
        let viewController = QuestionViewController(question: tempQuestion, options: tempOptions) {
            print($0)
        }
        _ = viewController.view
        viewController.tableView.allowsMultipleSelection = false
        window.rootViewController = viewController
        self.window = window
        self.window?.makeKeyAndVisible()
        return true
    }


}

