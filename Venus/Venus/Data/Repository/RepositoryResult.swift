//
//  RepositoryResult.swift
//  Venus
//
//  Created by Victoria Fargutu on 08.02.2021.
//

import Foundation

struct RepositoryResult<T: Decodable> {
    enum Error {
        case badRequest
        case noInternet
        case notFound
        case notAuthorized
        case other

        static func fromApiResponse<T>(apiResponse: ApiResponse<T>) -> Error {
            if apiResponse.isBadRequest {
                return .badRequest
            } else if apiResponse.isUnauthorized {
                return .notAuthorized
            } else if apiResponse.isNotFound {
                return .notFound
            } else if apiResponse.isNotConnectedToInternet {
                return .noInternet
            }
            return .other
        }
    }

    var value: T?
    var error: Error?
}
