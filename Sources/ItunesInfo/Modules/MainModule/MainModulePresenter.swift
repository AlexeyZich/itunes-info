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
            let baseError = BaseErrorModel(
                title: "Что-то пошло не так",
                message: "Сервер вернул пустые данные, повторите запрос"
            )
            self.viewController?.display(state: .displayError(baseError))
        case .noConnection:
            let baseError = BaseErrorModel(
                title: "Нет подключения к сети",
                message: "Проверьте подключение к сети и повторите запрос"
            )
            self.viewController?.display(state: .displayError(baseError))
        case .serverError:
            let baseError = BaseErrorModel(
                title: "Ошибка сервера",
                message: "Повторите запрос"
            )
            self.viewController?.display(state: .displayError(baseError))
        case .emptyParams:
            let baseError = BaseErrorModel(
                title: "Что-то пошло не так",
                message: "Проверьте параметры и повторите запрос"
            )
            self.viewController?.display(state: .displayError(baseError))
        case .unknown:
            let baseError = BaseErrorModel(
                title: "Что-то пошло не так",
                message: "Попробуйте повторить запрос"
            )
            self.viewController?.display(state: .displayError(baseError))
        case .parseError:
            let baseError = BaseErrorModel(
                title: "Что-то пошло не так",
                message: ""
            )
            self.viewController?.display(state: .displayError(baseError))
        }
    }
}
