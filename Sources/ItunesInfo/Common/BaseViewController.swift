//
//  BaseViewController.swift
//  ItunesInfo
//
//  Created by aleksejermolaev on 28.05.2021.
//

import UIKit
import DevTools

class BaseInteractor {

    init() { }
}

class BaseViewController: UIViewController {
    private let interactor: BaseInteractor
    let appNavigator: AppNavigatorProtocol

    init(interactor: BaseInteractor = BaseInteractor()) {
        self.interactor = interactor
        self.appNavigator = DI.container.resolve(AppNavigatorProtocol.self)!
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
