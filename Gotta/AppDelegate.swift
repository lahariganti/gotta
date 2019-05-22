//
//  AppDelegate.swift
//  gotta
//
//  Created by Lahari Ganti on 2/7/19.
//  Copyright © 2019 Lahari Ganti. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: CategoryVC())

        do {
            _  = try Realm()
        } catch {
            print(error)
        }
        return true
    }
}
