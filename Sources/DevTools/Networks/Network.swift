//
//  Network.swift
//  DevTools
//
//  Created by aleksejermolaev on 22.05.2021.
//

import Foundation
import Alamofire

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case xsrfToken = "X-XSRF-TOKEN"
    case jwtToken = "JWT-TOKEN"
    case connection = "Connection"
}

public typealias NetworkResult<T: Decodable> = Result<T, NetworkErrors>

public enum NetworkErrors: Error {
    case unknown
    case serverError
    case emptyData
    case emptyParams
    case parseError(String)
}

public protocol NetworkProtocol {
    var baseURL: URL { get }
    func makeRequest<T: Decodable>(to route: Router, completion: @escaping ((NetworkResult<T>) -> Void))
    func downloadData(url: URL, completion: @escaping ((NetworkResult<Data>) -> Void))
}

public class Network: NetworkProtocol {
    public let baseURL: URL

    public init(_ baseURL: URL) {
        self.baseURL = baseURL
    }

    public func makeRequest<T: Decodable>(to route: Router, completion: @escaping ((NetworkResult<T>) -> Void)) {
        guard route.needParams, !route.params.isEmpty else {
            completion(.failure(.emptyParams))
            return
        }
        if let url = convertURLComponents(route: route) {
            var request = URLRequest(url: url)
            request.setValue(ContentType.json.rawValue,
                             forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            send(request) { data in
                DispatchQueue.main.async {
                    completion(data)
                }
            }
        } else {
            print("url not created")
        }
    }

    public func downloadData(url: URL, completion: @escaping ((NetworkResult<Data>) -> Void)) {
        let urlRequest = URLRequest(url: url)
        send(urlRequest) { data in
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }

    private func send<T: Decodable>(_ request: URLRequest, completion: @escaping ((NetworkResult<T>) -> Void)) {
        AF.request(request).responseJSON { response in
            guard let statusCode = response.response?.statusCode else {
                completion(.failure(.unknown))
                return
            }
            guard 200...299 ~= statusCode else {
                completion(.failure(.serverError))
                return
            }
            guard let data = response.data else {
                completion(.failure(.emptyData))
                return
            }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch let error {
                completion(.failure(.parseError(error.localizedDescription)))
            }
        }
    }

    private func send(_ request: URLRequest, completion: @escaping ((NetworkResult<Data>) -> Void)) {
        AF.request(request).responseJSON { response in
            guard let statusCode = response.response?.statusCode else {
                completion(.failure(.unknown))
                return
            }
            guard 200...299 ~= statusCode else {
                completion(.failure(.serverError))
                return
            }
            guard let data = response.data else {
                completion(.failure(.emptyData))
                return
            }
            completion(.success(data))
        }
    }

    private func convertURLComponents(route: Router) -> URL? {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        components?.path = route.path
        components?.queryItems = convertQueryItem(params: route.params)
        return components?.url
    }

    private func convertQueryItem(params: [String: String]) -> [URLQueryItem] {
        return params.map { key, value in
            return URLQueryItem(name: key, value: value)
        }
    }
}
