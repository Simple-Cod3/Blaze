//
//  ForecastBackend.swift
//  Blaze
//
//  Created by Max on 9/10/20.
//

import Foundation
import SwiftUI

/// Manages the fires behinds the scenes and updates UI accordingly
class ForecastBackend: ObservableObject {
    
    @Published var forecasts = [Forecast]()
    
    

    init(forecasts: [Forecast]? = nil) {
        if let forecasts = forecasts {
            self.forecasts = forecasts
        }
    }
    
    
    func refreshForecastList(with: URL? = nil) {
        let group = DispatchGroup()
        
        let url = with ?? URL(string: "https://www.airnowapi.org/aq/forecast/latLong/?format=application/json&latitude=37.603630&longitude=-122.397202&distance=25&API_KEY=66FFCDB4-8501-45B5-B56F-60A2CAF8BA63")!
        
        print("==== [ Grabbing new forecasts ] ====")
        
        group.enter()
        URLSession.shared.dataTask(with: url) { unsafeData, reponse, error in
            guard let data: Data = unsafeData else {
                print("* No data found")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            jsonDecoder.dateDecodingStrategyFormatters = [
                DateFormatter.iso8601Full,
                DateFormatter.iso8601,
                DateFormatter.iso8601NoExtention,
            ]
            
            do {
                let newForecast = try jsonDecoder.decode([Forecast].self, from: data)
                self.forecasts = newForecast
            } catch {
                print("* JSON Decoding failed: \(error)")
            }
            
            group.leave()
        }.resume()
        
        
        
        group.notify(queue: .main) {
            print("Done!")
        }
    }
}


