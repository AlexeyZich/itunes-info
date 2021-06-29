//
//  DetailResult module
//  Created by Aleksey Ermolaev on 03/06/2021.
//

import UIKit
import DevTools

class DetailResultBuilder: ModuleBuilder {
    required init() {
        fatalError("Config not set")
    }
    
    struct Config {
        let detail: SearchResults.Result
    }

    private var config: Config

    init(_ config: Config) {
        self.config = config
    }

    func build() -> UIViewController {
        let presenter = DetailResultPresenter()
        let interactor = DetailResultInteractor(presenter: presenter, config: config)
        let controller = DetailResultViewController(interactor: interactor)

        presenter.viewController = controller
        return controller
    }
}
