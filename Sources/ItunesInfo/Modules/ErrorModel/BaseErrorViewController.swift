//
//  BaseErrorViewController.swift
//  ItunesInfo
//
//  Created by aleksejermolaev on 05.07.2021.
//

import UIKit
import DevTools

final class BaseErrorViewController: BaseViewController {

    private let customView = BaseErrorView(frame: UIScreen.main.bounds)
    private let config: BaseErrorBuilder.Config

    init(config: BaseErrorBuilder.Config) {
        self.config = config
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.set(model: config.model)
    }
}
