//
//  SecondModule module
//  Created by Aleksey Ermolaev on 20/05/2021.
//

enum SecondModule {
    // MARK: Use cases

    enum ViewControllerState {
        case loading
        case stopLoading
    }

    enum SecondModuleError: Error {
        case someError(message: String)
    }
}
