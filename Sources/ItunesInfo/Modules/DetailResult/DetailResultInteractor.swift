//
//  DetailResult module
//  Created by Aleksey Ermolaev on 03/06/2021.
//

import Foundation

protocol DetailResultBusinessLogic {
    func initialState()
    func startPlayPreview()
}

/// Класс для описания бизнес-логики модуля DetailResult
class DetailResultInteractor: DetailResultBusinessLogic {
    let presenter: DetailResultPresentationLogic
    let detail: SearchResults.Result
    let provider: DetailResultProviderProtocol

    init(
        presenter: DetailResultPresentationLogic,
        config: DetailResultBuilder.Config,
        provider: DetailResultProviderProtocol = DetailResultProvider()
    ) {
        self.presenter = presenter
        self.detail = config.detail
        self.provider = provider
    }

    func initialState() {
        presenter.present(.result(detail))
    }

    func startPlayPreview() {
        self.presenter.present(.loadingPreview)
        guard let previewURL = detail.previewUrl,
              let url = URL(string: previewURL) else { return }
        provider.downloadMusic(url: url) { [weak self] response in
            self?.presenter.present(.stopLoadingPreview)
            switch response {
            case .success(let data):
                self?.presenter.present(.startPlay(data))
            case .failure(let error):
                self?.presenter.present(.error(error))
            }
        }
    }
}
