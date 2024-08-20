//
// NetworkCaller.swift
//

import Foundation
import SystemConfiguration
import Combine

class NetworkCaller: NetworkCallerProtocol {    
    private var session: URLSessionProtocol
    private var networkLogger: NetworkLogger
    private let jsonEncoder: JSONEncoder
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForRequest = 5
        self.session = URLSession(configuration: configuration)
        
        networkLogger = ConsoleLoggerConsole()
        jsonEncoder = JSONEncoder()
    }
    
    init(
        session: URLSessionProtocol,
        networkLogger: NetworkLogger,
        jsonEncoder: JSONEncoder = .init()
    ) {
        self.session = session
        self.networkLogger = networkLogger
        self.jsonEncoder = jsonEncoder
    }
    
    func request(
        withEndPoint endPoint: EndpointProtocol
    ) async throws -> Data {
        guard endPoint.httpMethod == .get else {
            return try await upload(withEndPoint: endPoint)
        }
//        log(request: getURLRequest(forEndPoint: endPoint), body: nil)
        
        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await session.data(
                for: getURLRequest(forEndPoint: endPoint)
            )
        } catch {
            throw APIError.transportError(error)
        }
        
        return try await handleThrow(
            data: data,
            response: response
        )
    }
}

// MARK: Private functions
extension NetworkCaller {
    /// used for except GET request
    private func upload(
        withEndPoint endPoint: EndpointProtocol
    ) async throws -> Data {
        guard let body = endPoint.body else {
            throw APIError.invalidRequest("Body Empty")
        }
        
        let requestData: Data
        do {
            requestData = try JSONEncoder().encode(body)
        } catch EncodingError.invalidValue(_, let context) {
            throw APIError.encodingError(context.underlyingError)
        }
        //        log(request: getURLRequest(forEndPoint: endPoint), body: requestData)
        
        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await session.upload(
                for: getURLRequest(forEndPoint: endPoint),
                from: requestData
            )
        } catch {
            throw APIError.transportError(error)
        }
        
        return try await handleThrow(data: data, response: response)
    }
    
    private func handleThrow(
        data: Data,
        response: URLResponse
    ) async throws -> Data {
        guard let httpURLResponse = response as? HTTPURLResponse else {
            throw APIError.unknown("HTTPURLResponse not found")
        }
        
        //        log(data: data, response: httpURLResponse, error: nil)
        if (200..<300).contains(httpURLResponse.statusCode) {
            return data
        } else {
            if httpURLResponse.statusCode == 401 {
                throw APIError.sessionExpired
            }
            if httpURLResponse.statusCode == 500 {
                throw APIError.internalServerError
            }
            
            throw APIError.unknown(httpURLResponse.description)
        }
    }
    
    private func getURLRequest(
        forEndPoint endPoint: any EndpointProtocol
    ) async -> URLRequest {
        var request = URLRequest(url: endPoint.urlComponents.url!)
        request.httpMethod = endPoint.httpMethod.rawValue
        
        // set header start
        if let headers = endPoint.headers {
            for(headerField, headerValue) in headers {
                request.setValue(headerValue, forHTTPHeaderField: headerField)
            }
        }
        if endPoint.httpMethod != .get {
            request.setValue(
                "application/json; charset=utf-8",
                forHTTPHeaderField: HeaderKeys.contentType.rawValue
            )
        }
        return request
    }
}
