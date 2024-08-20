//
// APIError.swift
//

import Foundation

enum APIError: LocalizedError {
    case decodingError(Error) // badDataResponse, badErrorResponse
    case encodingError(Error?)
    case invalidRequest(String)
    case internalServerError
    case notFound(String?) // bad request
    case transportError(Error) // noInternet
    case sessionExpired
    case badRequest(String?)
    case errorResponseDecodingError(Data)
    case unknown(String)
    
    var errorDescription: String? {
#if DEBUG
        switch self {
        case .errorResponseDecodingError:
            return "Unable to decode error response."
        case .decodingError(let err):
            return "Decoding Error \(err.localizedDescription)"
        case .encodingError(let err):
            return "Encoding Error \(err?.localizedDescription ?? "")"
        case .invalidRequest(let msg):
            return "Invalid Request \(msg)"
        case .internalServerError:
            return "Oops! We encountered an unexpected issue. Please try again."
        case .notFound(let message):
            return message
        case .transportError(let err):
            return "Transport Error \(err.localizedDescription)"
        case .sessionExpired:
            return "Seems like your session has expired. Please Login again."
        case .badRequest(let errorMsg):
            return errorMsg
        case .unknown:
            return "Oops! We encountered an unknown issue. Please try again."
        }
#else
        switch self {
        case .errorResponseDecodingError, .decodingError, .encodingError, .invalidRequest, .notFound, .transportError, .unknown:
            return "Oops! We encountered an unknown issue. Please try again."
        case .internalServerError:
            return "Oops! We encountered an unexpected issue. Please try again."
        case .sessionExpired:
            return "Seems like your session has expired. Please Login again."
        case .badRequest(let errorMsg):
            return errorMsg
        }
#endif
    }
}
