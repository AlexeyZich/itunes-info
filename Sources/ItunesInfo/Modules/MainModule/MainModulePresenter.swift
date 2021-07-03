//
//  MainModule module
//  Created by Aleksey Ermolaev on 20/05/2021.
//

import UIKit
import DevTools

protocol MainModulePresentationLogic {
    func present(response: MainModule.Response)
}

/// Отвечает за отображение данных модуля MainModule
class MainModulePresenter: MainModulePresentationLogic {
    weak var viewController: MainModuleDisplayLogic?

    // MARK: Do something
    func present(response: MainModule.Response) {
        switch response {
        case .loading:
            self.viewController?.display(state: .loading)
        case .stopLoading:
            self.viewController?.display(state: .stopLoading)
        case .result(let results):
            self.viewController?.display(state: .displayResults(results))
            return
        case .error(let error):
            handleError(error)
        }
    }

    private func handleError(_ error: NetworkErrors) {
        switch error {
        case .emptyData:
            return
        case .noConnection:
            self.viewController?.display(state: .displayError(error))
            return
        default:
            return
        }
    }
}
