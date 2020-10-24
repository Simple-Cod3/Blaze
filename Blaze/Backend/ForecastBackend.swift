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
    @Published var forecasts = [AirQuality()]

    init(forecasts: [AirQuality]? = nil) {
        if let forecasts = forecasts {
            self.forecasts = forecasts
        }
    }

    // MARK: - Functions

    func refreshForecastList(with: URL? = nil) {
        let group = DispatchGroup()

        let lat = CLLocationManager().location?.coordinate.latitude ?? 37.7749
        let long = CLLocationManager().location?.coordinate.longitude ?? -122.4194

        let url = with ?? URL(string: "https://www.airnowapi.org/aq/observation/latLong/current/?format=application/json&latitude=\(lat)&longitude=\(long)&distance=25&API_KEY=66FFCDB4-8501-45B5-B56F-60A2CAF8BA63")!
        print(url.absoluteString)

        print("==== [ Grabbing new forecasts ] ====")

        group.enter()
        URLSession.shared.dataTask(with: url) { unsafeData, _, error in
            guard let data: Data = unsafeData else {
                print("* No data found")
                return
            }

            let jsonDecoder = JSONDecoder()

            jsonDecoder.dateDecodingStrategyFormatters = [
                DateFormatter.iso8601Full,
                DateFormatter.iso8601,
                DateFormatter.iso8601NoExtention
            ]

            do {
                let newForecast = try jsonDecoder.decode([AirQuality].self, from: data)
                self.forecasts = newForecast
            } catch {
                print("* JSON Decoding failed: \(error)")
            }

            group.leave()
        }.resume()

        group.notify(queue: .main) {
            print("Done grabbing forecast!")
        }
    }

    // MARK: - Computed Properties
    
    var aqiNow: String { String(forecasts[0].AQI) }
    var pollutantNow: String { forecasts[0].pollutant }
    var ozoneHealthNow: String { forecasts[0].category.Name }
    var currentLocation: String { forecasts[0].place }
}
