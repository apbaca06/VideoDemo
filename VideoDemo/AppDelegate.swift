//
//  AppDelegate.swift
//  VideoDemo
//
//  Created by cindy on 2018/1/19.
//  Copyright © 2018年 Jui-hsin.Chen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)

        window.rootViewController = ViewController()

        window.makeKeyAndVisible()
        self.window = window
        return true
    }

}
