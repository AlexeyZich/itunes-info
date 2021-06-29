//
//  DetailResult module
//  Created by Aleksey Ermolaev on 03/06/2021.
//

import UIKit

protocol DetailResultDisplayLogic: AnyObject {
    func display(state: DetailResult.ViewControllerState)
}

class DetailResultViewController: UIViewController {
    let interactor: DetailResultBusinessLogic
    let cusotmView = DetailResultView(frame: UIScreen.main.bounds)

    init(interactor: DetailResultBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View lifecycle
    override func loadView() {
        self.view = cusotmView
        cusotmView.delegate = self
        // make additional setup of view or save references to subviews
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.initialState()
    }
}

extension DetailResultViewController: DetailResultDisplayLogic {

    func display(state: DetailResult.ViewControllerState) {
        switch state {
        case .displayResult(let result):
            cusotmView.update(result)
        case .displayLoading:
            cusotmView.loading(isStart: true)
        case .displayStoploading:
            cusotmView.loading(isStart: false)
        case .displayStartPreview(let data):
            cusotmView.startPlay(data: data)
        }
    }
}

extension DetailResultViewController: DetailResultViewDelegate {
    func didPlayPreview() {
        interactor.startPlayPreview()
    }
}
