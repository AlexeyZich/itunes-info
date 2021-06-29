//
//  SecondModule module
//  Created by Aleksey Ermolaev on 20/05/2021.
//

import UIKit
import DevTools

class SecondModuleBuilder: ModuleBuilder {

    required init() {
        
    }
    
    func build() -> UIViewController {
        let presenter = SecondModulePresenter()
        let interactor = SecondModuleInteractor(presenter: presenter)
        let controller = SecondModuleViewController(interactor: interactor)

        presenter.viewController = controller
        return controller
    }
}
