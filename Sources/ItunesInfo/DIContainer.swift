//
//  DIContainer.swift
//  DevTools
//
//  Created by aleksejermolaev on 20.05.2021.
//

import DevTools
import Swinject
import UIKit

class DI {
    static let container = Container()

    static func registerAll() {
        container.register(AppNavigatorProtocol.self) { _ in
            let rootViewController = UINavigationController()
            return AppNavigator(rootViewController)
        }.inObjectScope(.container)
        container.register(NetworkMonitorProtocol.self) { _ in NetworkMonitor() }
            .inObjectScope(.container)
        container.register(NetworkProtocol.self) { resolver in
            Network(
                baseURL: Environment.rootURL,
                monitor: resolver.resolve(NetworkMonitorProtocol.self)!
            )
        }
    }
}
