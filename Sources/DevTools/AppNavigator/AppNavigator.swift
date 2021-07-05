//
//  AppNavigator.swift
//  ItunesInfo
//
//  Created by aleksejermolaev on 20.05.2021.
//

import UIKit

public protocol AppNavigatorProtocol {
    var navigationController: UINavigationController { get }
    func push(to module: ModuleBuilder, animated: Bool)
    func popToRoot(animated: Bool)
    func present(builder: ModuleBuilder, animated: Bool, completion: (() -> Void)?)
    func dissmis(completion: (() -> Void)?)
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

    public func present(builder: ModuleBuilder, animated: Bool, completion: (() -> Void)?) {
        let controller = builder.build()
        controller.modalPresentationStyle = .fullScreen
        navigationController.present(controller, animated: animated, completion: completion)
    }

    public func dissmis(completion: (() -> Void)? = nil) {
        navigationController.dismiss(animated: true, completion: completion)
    }
}
