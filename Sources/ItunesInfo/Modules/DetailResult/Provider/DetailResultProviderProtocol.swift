//
//  DetailResultProviderProtocol.swift
//  DevTools
//
//  Created by aleksejermolaev on 05.06.2021.
//

import Foundation
import DevTools

typealias PreviewMusicCompletion = ((Result<Data, PreviewMusicError>) -> Void)

enum PreviewMusicError: Error {
    case fileProviderNil
    case dataNotFound
    case networkError(NetworkErrors)
    case fileNotWrite
}

protocol DetailResultProviderProtocol {
    func downloadMusic(url: URL, completion: @escaping PreviewMusicCompletion)
}

final class DetailResultProvider: DetailResultProviderProtocol {
    
    private let fileProvider: FileProviderProtocol?
    private let networkProvider: NetworkProtocol?

    init(
        fileProvider: FileProviderProtocol? = FileProvider(component: "Sounds"),
        networkProvider: NetworkProtocol = DI.container.resolve(NetworkProtocol.self)!
    ) {
        self.fileProvider = fileProvider
        self.networkProvider = networkProvider
    }
    func downloadMusic(url: URL, completion: @escaping PreviewMusicCompletion) {
        guard let fileProvider = fileProvider else {
            completion(.failure(.fileProviderNil))
            return
        }
        if fileProvider.fileExists(by: url.absoluteString) {
            guard let data = fileProvider.getContentFromFile(by: url.absoluteString) else {
                completion(.failure(.dataNotFound))
                return
            }
            completion(.success(data))
        } else {
            networkProvider?.downloadData(url: url) { (response: Result<Data, NetworkErrors>) in
                switch response {
                case .success(let data):
                    if let path = fileProvider.write(data: data, with: url.absoluteString) {
                        completion(.success(path))
                    } else {
                        completion(.failure(.fileNotWrite))
                    }
                    return
                case .failure(let error):
                    completion(.failure(.networkError(error)))
                }
            }
        }
    }
}
