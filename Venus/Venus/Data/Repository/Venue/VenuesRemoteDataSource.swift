//
//  VenuesRemoteDataSource.swift
//  Venus
//
//  Created by Victoria Fargutu on 08.02.2021.
//

import Alamofire

class VenuesRemoteDataSource: AlamofireAPI {
  
    //MARK: - Endpoints
    func venuesEndpoint() -> URLComponents {
        return URLComponents(string: baseURL + "/venues/explore")!
    }
    
    //MARK: - API calls
    func getVenues(params: VenueRequestModel, completion: @escaping (ApiResponse<VenueRecommendationsEntity>) -> Void) {
        session.request(venuesEndpoint(), method: .get, parameters: params)
            .log(.verbose)
            .validate()
            .responseDecodable() { (response: AFDataResponse<Response<VenueRecommendationsEntity>>) in
                self.deliverResult(response, completionHandler: completion)
            }
    }
}
