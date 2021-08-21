//
//  Hero.swift
//  Hero
//
//  Created by Paul Wong on 8/19/21.
//

import SwiftUI

struct Hero: View {
    
    @EnvironmentObject var forecast: AirQualityBackend
    
    @Binding var aqi: Bool
    
    init(aqi: Binding<Bool>) {
        self._aqi = aqi
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(spacing: 5) {
                Image(systemName: aqi ? "aqi.high" : "flame")
                    .font(.body.bold())
                    .foregroundColor(.white)
                
                Text(aqi ? "Air Quality" : "Wildfires")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Spacer()
            
                Text(aqi ? "See Wildfires" : "See AQI")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.white.opacity(0.7))

                Image(systemName: aqi ? "flame" : "aqi.high")
                    .font(.caption)
                    .foregroundColor(.white)
            }
            
            Text(aqi ? "Displaying air quality in San Francisco." : "Showing 390 hotspots across the United States.")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.7))
        }
        .padding(20)
        .background(aqi ? determineColor(cat: forecast.forecasts[1].category.number) : Color.blaze)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}
