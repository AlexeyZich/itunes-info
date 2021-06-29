//
//  SearchParams.swift
//  DevTools
//
//  Created by aleksejermolaev on 27.05.2021.
//

import Foundation

public enum MediaType: String, Encodable {
    case movie
    case podcast
    case music
    case musicVideo
    case audiobook
    case all
}

public struct SearchParams: Encodable {
    let term: String
    let limit: String
    let country: String
    let media: MediaType

    public init(
        term: String,
        limit: String = "1",
        country: String = "en",
        media: MediaType = .all
    ) {
        self.term = term
        self.limit = limit
        self.country = country
        self.media = media
    }
}
