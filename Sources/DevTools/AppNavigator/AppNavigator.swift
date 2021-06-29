//
//  AppNavigator.swift
//  ItunesInfo
//
//  Created by aleksejermolaev on 20.05.2021.
//

import UIKit

public protocol AppNavigatorProtocol {
    var navigationController: UINavigationController { get }
    func push(to module: ModuleBuilder, animated: Bool )
    func popToRoot(animated: Bool)
}

public class AppNavigator: AppNavigatorProtocol {

    public let navigationController: UINavigationController
    
    public init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func push(to module: ModuleBuilder, animated: Bool = true) {
        let controller = module.build()
        navigationController.pushViewController(controller, animated: animated)
    }

    public  func popToRoot(animated: Bool = true) {
        navigationController.popToRootViewController(animated: animated)
    }
}
