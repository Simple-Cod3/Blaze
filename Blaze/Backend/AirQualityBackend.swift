//
//  ForecastBackend.swift
//  Blaze
//
//  Created by Max on 9/10/20.
//

import Foundation
import SwiftUI
import CoreLocation

/// Manages the fires behinds the scenes and updates UI accordingly
class AirQualityBackend: ObservableObject {
    @Published var forecasts = [AirQuality(), AirQuality()]
    @Published var lost = false
    
    var locationProvider = LocationProvider()
    var progress = Progress()

    init(forecasts: [AirQuality]? = nil) {
        do {
            locationProvider.lm.allowsBackgroundLocationUpdates = false
            try locationProvider.start()
        }
        catch {
            print("!!! 🚫 Failed to get access to location 🚫 !!!")
            locationProvider.requestAuthorization()
        }
        
        if let forecasts = forecasts {
            self.forecasts = forecasts
        }
    }
    
    // MARK: - Functions
    
    func refreshForecastList(with: URL? = nil) {
        let start = Date()
        self.lost = false
        let group = DispatchGroup()
        
        var lat = locationProvider.location?.coordinate.latitude
        var long = locationProvider.location?.coordinate.longitude
        
        if lat == nil || long == nil {
            lat = 37.7749
            long = -122.4194
            self.lost = true
        }
        
        let url = with ?? URL(string: "https://www.airnowapi.org/aq/observation/latLong/current/?format=application/json&latitude=\(lat!)&longitude=\(long!)&distance=25&API_KEY=66FFCDB4-8501-45B5-B56F-60A2CAF8BA63")!
        
        print("☁️ [ Grabbing new forecasts at (\(lat!), \(long!)) ]")
        
        let task = URLSession.shared.dataTask(with: url) { unsafeData, reponse, error in
            guard let data: Data = unsafeData else {
                print("🚫 No data found")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            jsonDecoder.dateDecodingStrategyFormatters = [
                DateFormatter.iso8601Full,
                DateFormatter.iso8601,
                DateFormatter.iso8601NoExtention,
            ]
            
            DispatchQueue.main.async {
                do {
                    let newForecast = try jsonDecoder.decode([AirQuality].self, from: data)
                    for report in newForecast {
                        if report.pollutant == "O3" {
                            self.forecasts[0] = report
                        } else if report.pollutant == "PM2.5" {
                            self.forecasts[1] = report
                        }
                    }
                } catch {
                    print("🚫 JSON Decoding failed: \(error)")
                }
                group.leave()
            }
        }
        
        self.progress = task.progress
        
        group.enter()
        task.resume()
        
        group.notify(queue: .main) {
            print("✅ Done grabbing forecast! (\(round(1000.0 * Date().timeIntervalSince(start)) / 1000.0))")
        }
    }
    
    // MARK: - Computed Properties
    
    var aqiOzone: String {
        get { String(forecasts[0].AQI) }
    }
    
    var aqiPollutant: String {
        get { String(forecasts[1].AQI) }
    }
    
    var pollutantOzone: String {
        get { forecasts[0].pollutant }
    }
    
    var pollutant: String {
        get { String(forecasts[1].pollutant) }
    }
    
    var ozoneHealth: String {
        get { forecasts[0].category.Name }
    }
    
    var currentLocation: String {
        get { forecasts[0].place }
    }
}


