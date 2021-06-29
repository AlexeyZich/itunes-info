//
//  FileManager.swift
//  DevTools
//
//  Created by aleksejermolaev on 05.06.2021.
//

import Foundation

public protocol FileProviderProtocol {
    var path: String { get }
    var searchPathDirectory: Foundation.FileManager.SearchPathDirectory { get }
    var domainMask: Foundation.FileManager.SearchPathDomainMask { get }
    init?(component path: String)
    func createDirectoryIfNeeded() throws
    func fileExists(by path: String) -> Bool
    func getContentFromFile(by path: String) -> Data?
    func write(data: Data, with path: String) -> Data?
}

public enum FileProviderError: Error {
    case documentDirectoryNotFound
    case notCreate(String)
}

public class FileProvider: FileProviderProtocol {
    public let path: String
    public let searchPathDirectory: FileManager.SearchPathDirectory
    public var domainMask: FileManager.SearchPathDomainMask
    private let fileManager: FileManager
    private var dataPath: URL?

    required public init?(component path: String) {
        self.path = path
        self.searchPathDirectory = .libraryDirectory
        self.domainMask = .userDomainMask
        self.fileManager = Foundation.FileManager.default
        do {
            try self.createDirectoryIfNeeded()
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    public func createDirectoryIfNeeded() throws {
        let paths = NSSearchPathForDirectoriesInDomains(searchPathDirectory, domainMask, true)
        guard let documentsDirectory = paths.first,
              let docURL = URL(string: documentsDirectory) else {
            throw FileProviderError.documentDirectoryNotFound
        }
        let dataPath = docURL.appendingPathComponent(path)
        self.dataPath = dataPath
        if !fileManager.fileExists(atPath: dataPath.path) {
            do {
                try fileManager.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
                print("directory created at \(dataPath)")
            } catch {
                throw FileProviderError.notCreate(error.localizedDescription)
            }
        }
    }

    public func fileExists(by path: String) -> Bool {
        guard let dataPath = dataPath else { return false }
        let filePath = dataPath.appendingPathComponent(path)
        return fileManager.fileExists(atPath: filePath.path)
    }

    public func getContentFromFile(by path: String) -> Data? {
        guard let dataPath = dataPath else { return nil }
        let filePath = dataPath.appendingPathComponent(path)
        do {
            return try fileManager.contents(atPath: filePath.path)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    public func write(data: Data, with path: String) -> Data? {
        guard let dataPath = dataPath else { return nil }
        let filePath = dataPath.appendingPathComponent(path)
        do {
            try fileManager.createFile(atPath: filePath.path, contents: data, attributes: nil)
            return getContentFromFile(by: path)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
