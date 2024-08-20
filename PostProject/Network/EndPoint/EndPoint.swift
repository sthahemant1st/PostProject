//
//  EndPoint.swift
//

import Foundation

struct EndPoint: EndpointProtocol {
    var scheme: String
    var baseUrl: String
    var path: String
    var httpMethod: HTTPMethod
    var headers: HTTPHeaders?
    var body: Encodable?
    var queryItems: [URLQueryItem]?
    var percentEncodedQueryItems: [URLQueryItem]?
    var isFormURLEncoded: Bool
    
    init(
        path: String,
        httpMethod: HTTPMethod,
        scheme: String = "https",
        baseUrl: String = "6335259f849edb52d6fc398e.mockapi.io",
        headers: HTTPHeaders? = nil,
        body: Encodable? = nil,
        queryItems: [URLQueryItem]? = nil,
        percentEncodedQueryItems: [URLQueryItem]? = nil,
        isFormURLEncoded: Bool = false
    ) {
        self.path = path
        self.httpMethod = httpMethod
        self.baseUrl = baseUrl
        self.scheme = scheme
        self.headers = headers
        self.body = body
        self.queryItems = queryItems
        self.percentEncodedQueryItems = percentEncodedQueryItems
        self.isFormURLEncoded = isFormURLEncoded
    }
    
    static let dummy: EndPoint = .init(
        path: "/web-n-app-tasks/posts",
        httpMethod: .get
    )
}

