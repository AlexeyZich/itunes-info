//
//  MainModule module
//  Created by Aleksey Ermolaev on 20/05/2021.
//

import DevTools

protocol MainModuleBusinessLogic {
    func request()
}

/// Класс для описания бизнес-логики модуля MainModule
class MainModuleInteractor: MainModuleBusinessLogic {
    let presenter: MainModulePresentationLogic
    private let network: NetworkProtocol

    init(
        presenter: MainModulePresentationLogic,
        network: NetworkProtocol = DI.container.resolve(NetworkProtocol.self)!
    ) {
        self.presenter = presenter
        self.network = network
    }
    
    // MARK: Do something

    func request() {
        presenter.present(response: .loading)
        let searchParams = SearchParams(term: "mgmt", limit: "10", country: "ru", media: .music)
        network.makeRequest(to: .search(searchParams)) { [weak self] (response: Result<SearchResults, NetworkErrors>) in
            self?.presenter.present(response: .stopLoading)
            switch response {
            case .success(let result):
                self?.presenter.present(response: .result(result))
            case .failure(let error):
                self?.presenter.present(response: .error(error))
            }
        }
    }
}
