//
//  SearchResults.swift
//  DevTools
//
//  Created by aleksejermolaev on 30.05.2021.
//

import Foundation

enum WrapperType: String, Decodable {
    case track
    case collection
    case artistFor
}

public struct SearchResults: Decodable {
    let count: Int
    let results: [Result]

    struct Result: Decodable {
        let wrapperType: WrapperType
        let artistName: String
        let trackName: String
        let previewUrl: String?
        let artwork: String?

        enum CodingKeys: String, CodingKey {
            case wrapperType = "wrapperType"
            case artistName = "artistName"
            case trackName = "trackName"
            case previewUrl = "previewUrl"
            case artwork = "artworkUrl100"
        }
    }

    enum CodingKeys: String, CodingKey {
        case count = "resultCount"
        case results = "results"
    }
}
