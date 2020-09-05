//
//  ForestFire.swift
//  Blaze
//
//  Created by Nathan Choi on 9/2/20.
//

import Foundation

/// Represents a forest fire
struct ForestFire: Codable, Comparable {
    static func < (lhs: ForestFire, rhs: ForestFire) -> Bool {
        return lhs.updated < rhs.updated
    }
    
    static func > (lhs: ForestFire, rhs: ForestFire) -> Bool {
        return lhs.updated > rhs.updated
    }
    
    var name: String
    var updated: Date
    var start: Date
    var county: String
    var location: String
    var acres: Double
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
    
    func getContained() -> String {
        return "\(contained)%"
    }
    
    func getAreaString() -> String {
        return "\(acres.inCommas() ?? String(acres)) Acres"
    }
    
    func getLocation() -> String {
        if location == "see details below" {
            return "More details on the website"
        }
        
        return location.prefix(1).capitalized + location.dropFirst()
    }
}
