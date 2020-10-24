//
//  Forecast.swift
//  Blaze
//
//  Created by Max on 9/9/20.
//

import Foundation
import MapKit

/// A data structure that represents a forest fire
struct AirQuality: Codable, Identifiable {
    // Comparable Protocol Functions
    
    var id = UUID()
    var dateObserved: String /// date of the request
    var place: String /// the place where it occured(ie San Francisco)
    var stateCode: String ///  state code of the fire(ie CA)
    var latitude: Double /// estimated starting location (latitude)
    var longitude: Double /// estimated starting location (longitude)
    var pollutant: String /// the pollutant
    var AQI: Int /// air quality index
    var category: Category
    
    struct Category: Codable {
        let number: Int
        let name: String
        
        enum CodingKeys: String, CodingKey {
            case number = "Number"
            case name = "Name"
        }
    }
    
    /// Everything is optional!
    init(dateIssue: String? = "-/-/-", place: String? = "Unknown", stateCode: String? = "CA", latitude: Double? = 0.0, longitude: Double? = 0.0, pollutant: String? = "Unknown", AQI: Int? = -1) {
        self.dateObserved = dateIssue!
        self.place = place!
        self.stateCode = stateCode!
        self.latitude = latitude!
        self.longitude = longitude!
        self.pollutant = pollutant!
        self.AQI = AQI!
        self.category = Category(number: -1, name: "Unknown")
    }
    
    // CodingKeys
    
    enum CodingKeys: String, CodingKey {
        case dateObserved = "DateObserved"
        case place = "ReportingArea"
        case stateCode = "StateCode"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case pollutant = "ParameterName"
        case AQI = "AQI"
        case category = "Category"
    }
    
    // MARK: - Functions
    func getDate() -> String {
        if dateObserved == "-/-/-" {
            return dateObserved
        }
        
        let dformatter = DateFormatter()
        dformatter.locale = Locale(identifier: "en_US_POSIX")
        dformatter.dateFormat = "yyyy-MM-dd"
        
        let date = dformatter.date(from: dateObserved.replacingOccurrences(of: " ", with: ""))
        dformatter.dateFormat = "MMMM d"
        return dformatter.string(from: date!)
    }
    
    // MARK: - Computed Properties
    
    /// Computes a `CLLocationCoordinate2D` from the latitude and longitude attribute
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
