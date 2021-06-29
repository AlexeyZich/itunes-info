//
//  Environment.swift
//  ItunesInfo
//
//  Created by aleksejermolaev on 27.05.2021.
//

import Foundation

enum Environment {
    enum Plist {
        struct Keys {
            static let rootURL = "ROOT_URL"
        }
    }

    private static var infoDictionary: [String: Any] {
        guard let dictionary = Bundle.main.infoDictionary else {
            fatalError("dictionary not found")
        }
        return dictionary
    }

    static var rootURL: URL {
        guard let urlString = infoDictionary[Plist.Keys.rootURL] as? String else {
            fatalError("Key\(Plist.Keys.rootURL) not found")
        }
        guard let url = URL(string: urlString) else {
            fatalError("Root HTTP url is invalid")
        }
        return url
    }
}
