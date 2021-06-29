//
//  DetailResult module
//  Created by Aleksey Ermolaev on 03/06/2021.
//

import UIKit

protocol DetailResultPresentationLogic {
    func present(_ response: DetailResult.Result)
}

/// Отвечает за отображение данных модуля DetailResult
class DetailResultPresenter: DetailResultPresentationLogic {
    weak var viewController: DetailResultDisplayLogic?

    // MARK: Do something
    func present(_ response: DetailResult.Result) {
        switch response {
        case .result(let result):
            viewController?.display(state: .displayResult(result))
        case .loadingPreview:
            viewController?.display(state: .displayLoading)
        case .stopLoadingPreview:
            viewController?.display(state: .displayStoploading)
        case .startPlay(let data):
            viewController?.display(state: .displayStartPreview(data))
        case .error(let error):
            handle(error)
        }
    }

    private func handle(_ error: PreviewMusicError) {
        switch error {
        case .dataNotFound:
            return
        case .fileNotWrite:
            return
        case .fileProviderNil:
            return
        default:
            return
        }
    }
}
