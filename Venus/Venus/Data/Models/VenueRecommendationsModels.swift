//
//  VenueRecommendationsModels.swift
//  Venus
//
//  Created by Victoria Fargutu on 08.02.2021.
//

import Foundation

struct VenueRecommendationsEntity: Decodable {
    let suggestedRadius: Int? //missing on some objects; breaks deserialization when missing
    let groups: [VenueRecommendationsGroupEntity]
    
    private enum CodingKeys: String, CodingKey {
        case suggestedRadius
        case groups
    }
}

struct VenueRecommendationsGroupEntity: Decodable {
    let items: [VenueRecommendationsGroupItemEntity]
    
    private enum CodingKeys: String, CodingKey {
        case items
    }
}

struct VenueRecommendationsGroupItemEntity: Decodable {
    let venue: VenueEntity
    
    private enum CodingKeys: String, CodingKey {
        case venue
    }
}

struct VenueEntity: Decodable {
    let id: String
    let name: String
    let location: LocationEntity
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case location
    }
}

struct LocationEntity: Decodable {
//    let address: String? //missing on some objects
    let distance: Int64
//    let postalCode: String //missing on some objects
    let city: String
    let formattedAddress: [String]
    
    private enum CodingKeys: String, CodingKey {
        case distance
        case city
        case formattedAddress
    }
}
