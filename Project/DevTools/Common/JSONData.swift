//
//  JSONData.swift
//  DevTools
//
//  Created by aleksejermolaev on 27.05.2021.
//

import Foundation

extension Encodable {

    /// Encode into JSON and return `Data`
    private func jsonData() throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601
        return try encoder.encode(self)
    }

    var params: [String: String] {
        do {
            let json = try JSONSerialization.jsonObject(with: jsonData(), options: [])
            guard let dict = json as? [String: String] else { return [:] }
            return dict
        } catch (let error) {
            print(error.localizedDescription)
            return [:]
        }
    }
}
