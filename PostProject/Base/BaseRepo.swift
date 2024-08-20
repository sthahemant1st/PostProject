//
//  BaseRepo.swift
//  PostProject
//
//  Created by Hemant Shrestha on 20/08/2024.
//

import Foundation

protocol BaseRepo {
    func handleResponse<T: Decodable>(
        responseData: Data,
        returnType: T.Type
    ) async throws -> T
}

extension BaseRepo {
    func handleResponse<T: Decodable>(
        responseData: Data,
        returnType: T.Type
    ) async throws -> T {
        do {
            return try JSONDecoder().decode(T.self, from: responseData)
        } catch {
            throw error
        }
    }
}
