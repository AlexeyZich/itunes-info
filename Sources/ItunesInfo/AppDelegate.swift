//
//  AppDelegate.swift
//  ItunesInfo
//
//  Created by aleksejermolaev on 19.05.2021.
//

import UIKit
import Swinject
import DevTools

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appNavigator: AppNavigatorProtocol!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {

        DI.registerAll()

        appNavigator = DI.container.resolve(AppNavigatorProtocol.self)
        appNavigator.push(to: MainModuleBuilder(), animated: false)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appNavigator.navigationController
        window?.makeKeyAndVisible()

        return true
    }

}
