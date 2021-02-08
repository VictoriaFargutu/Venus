//
//  AlamofireAPI.swift
//  Venus
//
//  Created by Victoria Fargutu on 08.02.2021.
//

import Alamofire

private let sharedSession = Session()

protocol AlamofireAPI {
    var session: Session { get }
    var baseURL: String { get }
}

extension AlamofireAPI {
    var baseURL: String {
        return "https://api.foursquare.com/v2"
    }

    var session: Session {
        return sharedSession
    }
    
    internal func deliverResult<T>(_ response: AFDataResponse<Response<T>>, completionHandler: @escaping (ApiResponse<T>) -> Void) {
        let statusCode = response.response?.statusCode ?? 503
        let body = response.value?.response
        let error = response.error

        let apiResponse = ApiResponse(code: statusCode, body: body, error: error)
        completionHandler(apiResponse)
    }
}
