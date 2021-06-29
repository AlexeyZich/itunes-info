//
//  SecondModule module
//  Created by Aleksey Ermolaev on 20/05/2021.
//

protocol SecondModuleBusinessLogic {
    
}

/// Класс для описания бизнес-логики модуля SecondModule
class SecondModuleInteractor: SecondModuleBusinessLogic {
    let presenter: SecondModulePresentationLogic

    init(presenter: SecondModulePresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: Do something
}
