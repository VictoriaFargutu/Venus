//
//  VenuesViewModel.swift
//  Venus
//
//  Created by Victoria Fargutu on 08.02.2021.
//

import Foundation

class VenuesViewModel: VenuesServiceInjector {
    
    private var venues: [VenueModel] = []
    private var _radius: Int? = 0
    
    var latitude: Double = 0
    var longitude: Double = 0
    
    var onDataChanged: (() -> Void)?
    
    func loadVenues(radius: Int? = nil) {
        _radius = radius
        venuesService.getVenues(latitude: latitude, longitude: longitude, radius: radius) { [weak self] venues, radius, error in
            guard let venues = venues else { return }
            self?._radius = radius != nil ? radius! : self?._radius
            self?.venues = venues
            self?.onDataChanged?()
        }
    }
    
    func venuesCount() -> Int {
        return venues.count
    }
    
    func radius() -> Int {
        return _radius ?? 0
    }
    
    func venue(at indexPath: IndexPath) -> VenueModel {
        return venues[indexPath.row]
    }
}
