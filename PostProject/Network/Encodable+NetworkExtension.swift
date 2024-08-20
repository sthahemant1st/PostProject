//
// Encodable+NetworkExtension.swift
//

import Foundation

extension Encodable {
    func getRequestParameters() -> [String: Any]? {
        let jsonEncoder = JSONEncoder()
        if let jsonData = try? jsonEncoder.encode(self) {
            do {
                return  try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
            } catch {
                return nil
            }
        }
        return nil
    }
    
//    func getURLQueryItemsEncoded() -> [URLQueryItem]? {
//        let encoder = URLQueryItemEncoder()
//        var queryItems = try? encoder.encode(self)
//        if !queryItems.isNil {
//            for (index, queryItem) in queryItems!.enumerated() {
//                queryItems?[index].value = queryItem.value?.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
//            }
//        }
//        return queryItems
//    }
//    
//    func getURLQueryItems() -> [URLQueryItem]? {
//        let encoder = URLQueryItemEncoder()
//        var queryItems = try? encoder.encode(self)
//        if !queryItems.isNil {
//            for (index, queryItem) in queryItems!.enumerated() {
//                queryItems?[index].value = queryItem.value
//            }
//        }
//        return queryItems
//    }
}
