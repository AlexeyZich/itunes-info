//
//  MainModule module
//  Created by Aleksey Ermolaev on 20/05/2021.
//

import UIKit
import DevTools

protocol MainModuleDisplayLogic: AnyObject {
    func display(state: MainModule.ViewControllerState)
}

class MainModuleViewController: BaseViewController {
    let interactor: MainModuleBusinessLogic
    let tableAdapter: MainCollectionAdapter
    var customView: MainModuleView!

    init(interactor: MainModuleBusinessLogic) {
        self.interactor = interactor
        self.tableAdapter = MainCollectionAdapter()
        super.init()
        self.tableAdapter.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View lifecycle
    override func loadView() {
        customView = MainModuleView(frame: UIScreen.main.bounds,
                                  collectionView: tableAdapter.collectionView)
        view = self.customView
        customView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.request()
    }

}

extension MainModuleViewController: MainModuleDisplayLogic {

    func display(state: MainModule.ViewControllerState) {
        switch state {
        case .loading:
            customView.loading(state: .loading)
        case .stopLoading:
            customView.loading(state: .stopLoading)
        case .displayResults(let results):
            tableAdapter.update(viewModel: results)
        case .displayError(let error):
            return
        case .displayDetail(let detail):
            let config = DetailResultBuilder.Config(detail: detail)
            appNavigator.push(to: DetailResultBuilder(config), animated: true)
        }
    }
}

extension MainModuleViewController: MainModuleViewDelegate {
    func didPressed() {
        appNavigator.push(to: SecondModuleBuilder(), animated: true)
    }
}

extension MainModuleViewController: MainCollectionAdapterProtocol {
    func didSelect(_ result: SearchResults.Result) {
        display(state: .displayDetail(result))
    }
}
