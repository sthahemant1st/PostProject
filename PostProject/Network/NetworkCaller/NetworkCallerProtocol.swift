//
//  NetworkCallerProtocol.swift
//

import Foundation

protocol NetworkCallerProtocol {
    func request(
        withEndPoint endPoint: EndpointProtocol
    ) async throws -> Data
}
