//
//  VenueRepository.swift
//  Venus
//
//  Created by Victoria Fargutu on 08.02.2021.
//

import Foundation

protocol VenueRepository {
    func getVenues(params: VenueRequestModel, completion: @escaping (RepositoryResult<VenueRecommendationsEntity>) -> Void)
}

protocol VenueRepositoryInjector {
    var venueRepository: VenueRepository { get }
}

extension VenueRepositoryInjector{
    var venueRepository: VenueRepository {
        return VenueRepositoryImpl()
    }
}

class VenueRepositoryImpl: VenueRepository {
    
    let remoteSource = VenuesRemoteDataSource()
    
    func getVenues(params: VenueRequestModel, completion: @escaping (RepositoryResult<VenueRecommendationsEntity>) -> Void) {
        remoteSource.getVenues(params: params) { response in
            guard response.isSuccessful, let entity = response.body else {
                completion(RepositoryResult(value: nil, error: .fromApiResponse(apiResponse: response)))
                return
            }
            completion(RepositoryResult(value: entity, error: nil))
        }
    }
}
