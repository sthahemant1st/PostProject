//
//  NetworkLogger.swift
//

import Foundation

protocol NetworkLogger {
    func log(request: URLRequest, body: Data?)
    func log(data: Data?, response: HTTPURLResponse?, error: Error?)
}
