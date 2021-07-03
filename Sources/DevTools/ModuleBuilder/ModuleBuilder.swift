//
//  ModuleBuilder.swift
//  ItunesInfo
//
//  Created by aleksejermolaev on 20.05.2021.
//

import UIKit

public protocol ModuleBuilder: class {

    init()

    func build() -> UIViewController
}
