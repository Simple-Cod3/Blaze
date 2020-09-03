//
//  ForestFire.swift
//  Blaze
//
//  Created by Nathan Choi on 9/2/20.
//

import Foundation

/// Represents a forest fire
struct ForestFire: Codable {
    var name: String
    var updated: String
    var start: String
    var county: String
    var location: String
    var acres: String
    var contained: Double
    var longitude: Double
    var latitude: Double
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case updated = "Updated"
        case start = "Started"
        case county = "County"
        case location = "Location"
        case acres = "AcresBurned"
        case contained = "PercentContained"
        case longitude = "Longitude"
        case latitude = "Latitude"
        case url = "Url"
    }
}
