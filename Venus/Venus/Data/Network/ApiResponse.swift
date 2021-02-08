//
//  ApiResponse.swift
//  Venus
//
//  Created by Victoria Fargutu on 08.02.2021.
//

import Alamofire

struct ApiResponse<T> {
    var code: Int
    let body: T?
    var error: AFError?
}

extension ApiResponse {
    var isSuccessful: Bool {
        return (200..<300).contains(code)
    }

    var isBadRequest: Bool {
        return code == 400
    }

    var isUnauthorized: Bool {
        return code == 401
    }

    var isNotFound: Bool {
        return code == 404
    }

    var isConflict: Bool {
        return code == 409
    }

    var isNotConnectedToInternet: Bool {
        error?.isSessionTaskError ?? false
    }
}

