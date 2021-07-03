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
        let name = self.getNameFrom(path: url.path)
        if fileProvider.fileExists(by: name) {
            guard let data = fileProvider.getContentFromFile(by: name) else {
                completion(.failure(.dataNotFound))
                return
            }
            completion(.success(data))
        } else {
            networkProvider?.downloadData(url: url) { (response: Result<Data, NetworkErrors>) in
                switch response {
                case .success(let data):
                    if fileProvider.write(data: data, with: name) {
                        print("Data saved in file with name \(name)")
                    } else {
                        print("Data not saved in file")
                    }
                    completion(.success(data))
                    return
                case .failure(let error):
                    completion(.failure(.networkError(error)))
                }
            }
        }
    }

    private func getNameFrom(path: String) -> String {
        return path.components(separatedBy: "/").last ?? ""
    }
}
