//
//  VenuesService.swift
//  Venus
//
//  Created by Victoria Fargutu on 08.02.2021.
//

import Foundation

protocol VenuesService: class {
    func getVenues(latitude: Double, longitude: Double, radius: Int?, completion: @escaping ([VenueModel]?, Int?, AppError?) -> Void)
}

protocol VenuesServiceInjector {
    var venuesService: VenuesService { get }
}

extension VenuesServiceInjector {
    var venuesService: VenuesService {
        return VenuesServiceImpl()
    }
}

class VenuesServiceImpl: VenuesService, VenueRepositoryInjector {
    
    func getVenues(latitude: Double, longitude: Double, radius: Int?, completion: @escaping ([VenueModel]?, Int?, AppError?) -> Void) {
        let clientId = "1OO1OK1MBWBRALB3OH1EYYOUCQ1JMH3TTPLCJYJH2IZ3QKCV"
        let clientSecret = "5KAOWOAXBT15H5UANJD3XIN2XTQCI4CNL2YXNK4SOTZBAMJ0"
        let version = "20190425"
        let params = VenueRequestModel(clientId: clientId,
                                       clientSecret: clientSecret,
                                       version: version,
                                       radius: radius != nil ? "\(radius!)" : nil,
                                       latitudeLongitude: "\(latitude), \(longitude)")
        venueRepository.getVenues(params: params) { result in
            let venueRecommendationsEntity = result.value
            let radius = venueRecommendationsEntity?.suggestedRadius
            guard let entities = venueRecommendationsEntity?.groups.first?.items.compactMap({ $0.venue }) else {
                if let error = result.error {
                    switch error {
                    case .noInternet: completion([], nil, .noInternet)
                    case .notFound: completion([], nil, .notFound)
                    default: completion([], nil, .server)
                    }
                    return
                }
                completion([], nil, .server)
                return
            }
            let venues: [VenueModel] = entities.compactMap {
                VenueModel(name: $0.name,
                           location: $0.location.formattedAddress.joined(separator: ", "),
                           distance: "\($0.location.distance)m")
                }
            completion(venues, radius, nil)
        }
    }
}
