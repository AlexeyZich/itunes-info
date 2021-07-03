//
//  MainModule module
//  Created by Aleksey Ermolaev on 20/05/2021.
//

import UIKit
import DevTools

class MainModuleBuilder: ModuleBuilder {

    var initialState: MainModule.ViewControllerState?

    required init() {

    }

    func set(initialState: MainModule.ViewControllerState) -> MainModuleBuilder {
        self.initialState = initialState
        return self
    }

    func build() -> UIViewController {
        let presenter = MainModulePresenter()
        let interactor = MainModuleInteractor(presenter: presenter)
        let controller = MainModuleViewController(interactor: interactor)

        presenter.viewController = controller
        return controller
    }
}
