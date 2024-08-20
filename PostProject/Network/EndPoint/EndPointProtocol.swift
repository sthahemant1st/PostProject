//
// EndPointProtocol.swift
//

import Foundation

protocol EndpointProtocol {
    var scheme: String { get set }
    var baseUrl: String { get set }
    var path: String { get set }
    var httpMethod: HTTPMethod { get set }
    var headers: HTTPHeaders? { get set }
    var body: Encodable? { get set }
    var queryItems: [URLQueryItem]? { get set }
    var percentEncodedQueryItems: [URLQueryItem]? { get set }
    var isFormURLEncoded: Bool { get set }
}

extension EndpointProtocol {
    var urlComponents: URLComponents {
        var component = URLComponents()
        component.scheme = scheme
        component.host = baseUrl
        component.path = path
        if let queryItems {
            component.queryItems = queryItems
        }
        if let percentEncodedQueryItems {
            component.percentEncodedQueryItems = percentEncodedQueryItems
        }
        return component
    }
}
