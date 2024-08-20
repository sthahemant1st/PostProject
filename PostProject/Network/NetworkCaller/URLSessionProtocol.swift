//
//  URLSessionProtocol.swift
//

import Foundation

protocol URLSessionProtocol {
    func data(
        for request: URLRequest,
        delegate: (URLSessionTaskDelegate)?
    ) async throws -> (Data, URLResponse)
    func upload(
        for request: URLRequest,
        from bodyData: Data,
        delegate: (URLSessionTaskDelegate)?
    ) async throws -> (Data, URLResponse)
}

extension URLSessionProtocol {
    func data(
        for request: URLRequest,
        delegate: (URLSessionTaskDelegate)? = nil
    ) async throws -> (Data, URLResponse) {
        try await data(for: request, delegate: delegate)
    }
    func upload(
        for request: URLRequest,
        from bodyData: Data,
        delegate: (URLSessionTaskDelegate)? = nil
    ) async throws -> (Data, URLResponse) {
        try await upload(for: request, from: bodyData, delegate: delegate)
    }
}

extension URLSession: URLSessionProtocol {}
