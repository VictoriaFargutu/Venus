//
//  Meta.swift
//  Venus
//
//  Created by Victoria Fargutu on 08.02.2021.
//

import Foundation

struct Meta: Decodable {
    let code: Int
    let requestId: String
    
    private enum CodingKeys: String, CodingKey {
        case code
        case requestId
    }
}
