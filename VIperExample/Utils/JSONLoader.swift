//
//  JSONLoader.swift
//  VIperExample
//
//  Created by Diego on 9/10/24.
//

import Foundation

class JSONLoader {
    static func obtainResponseObjectFromJsonFile<T: Decodable>(pathResource: String, type: T.Type) -> T {
        let bundle = Bundle(for: JSONLoader.self)
        
        guard let url = bundle.url(forResource: pathResource, withExtension: "json"),
              let jsonData = try? Data(contentsOf: url),
              let response = try? JSONDecoder().decode(T.self, from: jsonData) else {
            abort()
        }

        return response
    }
}
