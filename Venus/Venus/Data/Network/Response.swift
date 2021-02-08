//
//  Response.swift
//  Venus
//
//  Created by Victoria Fargutu on 08.02.2021.
//

import Foundation

struct Response<T: Decodable>: Decodable {
    let meta: Meta?
    let response: T?

    private enum CodingKeys: String, CodingKey {
        case meta
        case response
    }
}
