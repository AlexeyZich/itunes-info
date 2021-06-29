//
//  SecondModule module
//  Created by Aleksey Ermolaev on 20/05/2021.
//

import UIKit

protocol SecondModuleDisplayLogic: class {
}

class SecondModuleViewController: UIViewController {
    let interactor: SecondModuleBusinessLogic
    var state: SecondModule.ViewControllerState

    init(interactor: SecondModuleBusinessLogic, initialState: SecondModule.ViewControllerState = .loading) {
        self.interactor = interactor
        self.state = initialState
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View lifecycle
    override func loadView() {
        let view = SecondModuleView(frame: UIScreen.main.bounds)
        self.view = view
        // make additional setup of view or save references to subviews
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SecondModuleViewController: SecondModuleDisplayLogic {

    func display(newState: SecondModule.ViewControllerState) {
        state = newState
        switch state {
        case .loading:
            print("loading...")
        case .stopLoading:
            return
        }
    }
}
