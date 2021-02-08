//
//  Alamofire+Extensions.swift
//  Venus
//
//  Created by Victoria Fargutu on 08.02.2021.
//

import Alamofire

extension DataRequest {
    public enum LogLevel {
        case simple
        case verbose
    }

    public func log(_ level: LogLevel = .simple) -> Self {
        switch level {
        case .simple:
            return logRequest(.simple).logResponse(.simple)
        case .verbose:
            return logRequest(.verbose).logResponse(.verbose)
        }
    }
}

extension DataRequest {
    /// The request logging level. `.simple` prints only the HTTP method and path; `.verbose` prints the request body as well.
    public enum RequestLogLevel {
        case simple
        case verbose
    }

    public func logRequest(_ level: RequestLogLevel = .simple) -> Self {
        return response { response in
            guard let method = response.request?.httpMethod, let path = response.request?.url?.absoluteURL else {
                return
            }
            Logger.debug(tag: "Alamofire", message: "--> \(method) \(path)")
            guard case .verbose = level else {
                return
            }
            if let headers = response.request?.allHTTPHeaderFields {
                headers.forEach {
                    key, value in
                    Logger.debug(tag: "Alamofire", message: "\(key):\(value)")
                }
            }

            if let data = response.request?.httpBody, let body = String(data: data, encoding: .utf8) {
                Logger.debug(tag: "Alamofire", message: body)
            }

            Logger.debug(tag: "Alamofire", message: "--> END \(method)")

            return
        }
    }
}

extension DataRequest {
    public enum ResponseLogLevel {
        case simple
        case verbose
    }

    public func logResponse(_ level: ResponseLogLevel = .simple) -> Self {
        return response {
            response in
            guard let code = response.response?.statusCode, let path = response.request?.url?.absoluteString else {
                return
            }
            let duration = Int((response.metrics?.taskInterval.duration ?? 0) * 1000)
            Logger.debug(tag: "Alamofire", message: "<-- \(code) \(path) (\(duration)ms)")

            guard case .verbose = level else {
                return
            }
            if let headers = response.response?.allHeaderFields {
                headers.forEach { key, value in
                    Logger.debug(tag: "Alamofire", message: "\(key): \(value)")
                }
            }

            var contentLength = 0

            if let data = response.data, let body = String(data: data, encoding: .utf8) {
                Logger.debug(tag: "Alamofire", message: "\(body)")
                contentLength = data.count
            }

            if let req = response.request, let url = req.url, let scheme = url.scheme {
                Logger.debug(tag: "Alamofire", message: "<-- END \(scheme.uppercased()) (\(contentLength)-byte body)")
            } else {
                Logger.debug(tag: "Alamofire", message: "<-- END HTTP (\(contentLength)-byte body)")
            }
        }
    }
}
