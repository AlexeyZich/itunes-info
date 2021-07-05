//
//  MainModule module
//  Created by Aleksey Ermolaev on 20/05/2021.
//

import DevTools

enum MainModule {

    enum Response {
        case loading
        case stopLoading
        case result(SearchResults)
        case error(NetworkErrors)
    }
    enum ViewControllerState {
        case loading
        case stopLoading
        case displayResults(SearchResults)
        case displayError(BaseErrorProtocol)
        case displayDetail(SearchResults.Result)
    }
}
