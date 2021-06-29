//
//  Router.swift
//  DevTools
//
//  Created by aleksejermolaev on 22.05.2021.
//

import Foundation
import Alamofire

public enum Router {
    case search(SearchParams)

    var path: String {
        switch self {
        case .search:
            return "/search"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }

    var params: [String: String] {
        switch self {
        case .search(let value):
            return value.params
        }
    }

    var needParams: Bool {
        switch self {
        case .search:
            return true
        }
    }
}
