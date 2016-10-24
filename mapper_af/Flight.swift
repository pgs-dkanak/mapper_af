//
//  Flight.swift
//  mapper_af
//
//  Created by pgs-dkanak on 22/10/16.
//  Copyright © 2016 pgs-dkanak. All rights reserved.
//

import Foundation
import ObjectMapper

// [{"id":1,"provider_logo":"http://cdn-goeuro.com/static_content/web/logos/{size}/air_berlin.png","price_in_euros":"38.88","departure_time":"1:23","arrival_time":"19:55","number_of_stops":0},{"id":2,"provider_logo":"http://cdn-goeuro.com/static_content/web/logos/{size}/transavia_airlines.png","price_in_euros":"75.95","departure_time":"1:06","arrival_time":"17:16","number_of_stops":1},

class Flight : Mappable {
    
    struct Key {
        static let id = "id"
        static let provider_logo = "provider_logo"
        static let price_in_euros = "price_in_euros"
        static let departure_time = "departure_time"
        static let arrival_time = "arrival_time"
        static let number_of_stops = "number_of_stops"
        
    }
    
    
    var id : Int = 0
    var providerLogoUrl = ""
    var price : Float = 0.0
    var departureTime : String = ""
    var arrivalTime : String = ""
    var numberOfStops : Int = 0
    
    
    func mapping(map: Map) {
        id <- map[Key.id]
        providerLogoUrl <- map[Key.provider_logo]
        price <- map[Key.price_in_euros]
        departureTime <- map[Key.departure_time]
        arrivalTime <- map[Key.arrival_time]
        numberOfStops <- map[Key.number_of_stops]
    }
    
    required init?(map: Map) {
        
    }
}
