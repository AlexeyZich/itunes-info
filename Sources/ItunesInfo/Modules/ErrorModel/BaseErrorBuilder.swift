//
//  BaseErrorBuilder.swift
//  ItunesInfo
//
//  Created by aleksejermolaev on 06.07.2021.
//

import DevTools
import UIKit

final class BaseErrorBuilder: ModuleBuilder {

    struct Config {
        let model: BaseErrorProtocol
        let completion: (() -> Void)?
    }
    let config: Config

    init(config: Config) {
        self.config = config
    }

    required init() {
        fatalError("Builder must be implemented with config")
    }

    func build() -> UIViewController {
        BaseErrorViewController(config: config)
    }
}
