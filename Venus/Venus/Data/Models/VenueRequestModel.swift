//
//  VenueRequestModel.swift
//  Venus
//
//  Created by Victoria Fargutu on 08.02.2021.
//

import Foundation

struct VenueRequestModel: Codable {
    let clientId: String
    let clientSecret: String
    let version: String
    let radius: String?
    let latitudeLongitude: String
    
    private enum CodingKeys: String, CodingKey {
        case clientId = "client_id"
        case clientSecret = "client_secret"
        case version = "v"
        case radius
        case latitudeLongitude = "ll"
    }
}
