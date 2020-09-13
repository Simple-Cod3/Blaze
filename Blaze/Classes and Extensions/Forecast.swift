//
//  ForeCast.swift
//  Blaze
//
//  Created by Max on 9/9/20.
//

import Foundation
import MapKit


struct Forecast: Codable, Identifiable {
    // Comparable Protocol Functions
    
<<<<<<< HEAD:Blaze/Classes and Extensions/Forecast.swift
    
    
=======
>>>>>>> 4798cd86fe442474518ce526070721d7ba0d46c7:Blaze/Classes and Extensions/ForeCast.swift
    var id = UUID()
    var dateIssue: String /// date of the request
    var dateForecast: String /// `Date` of when the data was last updated
    var place: String /// the place where it occured(ie San Francisco)
    var stateCode: String ///  state code of the fire(ie CA)
    var latitude: Double /// estimated starting location (latitude)
    var longitude: Double /// estimated starting location (longitude)
    var pollutant: String /// the pollutant idk
    var AQI: Int /// air quality index
    var actionDay: Bool /// weather you should take action
<<<<<<< HEAD:Blaze/Classes and Extensions/Forecast.swift
    //  Init
    init(dateIssue: String? = "12/3/4123", dateForecast: String? = "12/3/4123", place: String? = "place", stateCode: String? = "CA", latitude: Double? = 0.0, longitude: Double? = 0.0, pollutant: String? = "PULLUTENIT", AQI: Int? = -1, actionDay: Bool? = false) {
=======
    
    /// Everything is optional!
    init(dateIssue: Date? = Date(), dateForecast: Date? = Date(), place: String? = "place", stateCode: String? = "CA", latitude: Double? = 0.0, longitude: Double? = 0.0, pollutant: String? = "PULLUTENIT", AQI: Int? = -1, actionDay: Bool? = false) {
>>>>>>> 4798cd86fe442474518ce526070721d7ba0d46c7:Blaze/Classes and Extensions/ForeCast.swift
        self.dateIssue = dateIssue!
        self.dateForecast = dateForecast!
        self.place = place!
        self.stateCode = stateCode!
        self.latitude = latitude!
        self.longitude = longitude!
        self.pollutant = pollutant!
        self.AQI = AQI!
        self.actionDay = actionDay!
    }
    
    // CodingKeys
    
    enum CodingKeys: String, CodingKey {
        case dateIssue = "DateIssue"
        case dateForecast = "DateForecast"
        case place = "ReportingArea"
        case stateCode = "StateCode"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case pollutant = "ParameterName"
        case AQI = "AQI"
        case actionDay = "ActionDay"
    }
    
    
    /// Computes a `CLLocationCoordinate2D` from the latitude and longitude attribute
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
