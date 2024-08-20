//
//  JsonHelper.swift
//  PostProject
//
//  Created by Hemant Shrestha on 20/08/2024.
//

import Foundation

struct JsonHelper {
    private init() {}
    
    static func convert<T: Decodable>(name: String, type: T.Type) throws -> T {
        let url = Bundle.main.url(forResource: name, withExtension: "json")
        guard let url else { throw Error.fileNotFound }
        let data = try Data(contentsOf: url)
        let products = try JSONDecoder().decode(T.self, from: data)
        return products
    }
    
    enum Error: Swift.Error {
        case fileNotFound
    }
}
