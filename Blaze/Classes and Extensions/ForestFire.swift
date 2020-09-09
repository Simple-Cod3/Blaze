//
//  ForestFire.swift
//  Blaze
//
//  Created by Nathan Choi on 9/2/20.
//

import Foundation
import MapKit


/// A data structure that represents a forest fire
struct ForestFire: Codable, Comparable, Identifiable {
    // MARK: - Comparable Protocol Functions
    
    static func < (lhs: ForestFire, rhs: ForestFire) -> Bool {
        return lhs.updated < rhs.updated
    }
    
    static func > (lhs: ForestFire, rhs: ForestFire) -> Bool {
        return lhs.updated > rhs.updated
    }
    
    // MARK: - Attributes
    
    var id = UUID()
    var name: String /// name of the fire
    var updated: Date /// `Date` of when the data was last updated
    var start: Date /// `Date` of when the fire was first documented
    var county: String /// counties affected by the fire
    var location: String /// location(s) of the fire
    var acres: Double /// area in acres of the fire
    var contained: Double /// percent contained
    var longitude: Double /// estimated starting location (longitude)
    var latitude: Double /// estimated starting location (latitude)
    var url: String /// url of the fire for more information at https://fire.ca.gov/incidents
    
    // MARK: - Init
    init(name: String? = "Some Fire", updated: Date? = Date(), start: Date? = Date(), county: String? = "Some county", location: String? = "Some location", acres: Double? = 0, contained: Double? = 0, longitude: Double? = 36, latitude: Double? = 110, url: String? = "https://firenotfound") {
        self.name = name!
        self.updated = updated!
        self.start = start!
        self.county = county!
        self.location = location!
        self.acres = acres!
        self.contained = contained!
        self.longitude = longitude!
        self.latitude = latitude!
        self.url = url!
    }
    
    // MARK: - CodingKeys
    
    /// Specific for `https://fire.ca.gov/ API`
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
    
    // MARK: - String Functions
    
    /// Returns a formatted string of the percent contained
    func getContained() -> String {
        return "\(contained)%"
    }
    
    /// Returns a formatted string (with commas) of acres
    func getAreaString() -> String {
        return "\(acres.inCommas() ?? String(acres)) Acres"
    }
    
    /// Returns a formatted string (with proper responses) for the location
    func getLocation() -> String {
        if location.lowercased() == "see details below" {
            return "More details on the website"
        }
        
        return location.prefix(1).capitalized + location.dropFirst()
    }
    
    // MARK: - Computed Properties
    
    /// Computes a `CLLocationCoordinate2D` from the latitude and longitude attribute
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
