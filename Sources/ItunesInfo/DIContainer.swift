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
        container.register(NetworkProtocol.self) { _ in
            Network(Environment.rootURL)
        }
//        container.register(FileProviderProtocol?.self) { _ in
//        }
    }
}
