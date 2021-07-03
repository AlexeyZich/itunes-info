//
//  DetailResult module
//  Created by Aleksey Ermolaev on 03/06/2021.
//

import Foundation

enum DetailResult {

    enum Result {
        case result(SearchResults.Result)
        case loadingPreview
        case stopLoadingPreview
        case startPlay(Data)
        case error(PreviewMusicError)
    }

    enum ViewControllerState {
        case displayResult(SearchResults.Result)
        case displayLoading
        case displayStoploading
        case displayStartPreview(Data)
    }
}
