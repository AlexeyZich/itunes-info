//
//  BaseErrorModel.swift
//  ItunesInfo
//
//  Created by aleksejermolaev on 06.07.2021.
//

import Foundation

protocol BaseErrorProtocol {
    var title: String { get }
    var message: String { get }
}

struct BaseErrorModel: BaseErrorProtocol {
    let title: String
    let message: String
}
