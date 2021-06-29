//
//  SecondModule module
//  Created by Aleksey Ermolaev on 20/05/2021.
//

import UIKit

protocol SecondModulePresentationLogic {
}

/// Отвечает за отображение данных модуля SecondModule
class SecondModulePresenter: SecondModulePresentationLogic {
    weak var viewController: SecondModuleDisplayLogic?

    // MARK: Do something
}
