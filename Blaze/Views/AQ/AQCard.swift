//
//  AQCard.swift
//  Blaze
//
//  Created by Paul Wong on 9/9/20.
//

import SwiftUI

struct AQCard: View {
    
    @Environment(\.colorScheme) var colorScheme

    @EnvironmentObject var forecast: AirQualityBackend
    
    private var ozone: String
    private var ozoneAQI: String
    private var primaryPollutant: String
    private var primaryPollutantType: String
    private var primaryPollutantAQI: String
    
    init (ozone: AirQuality?=nil, primary: AirQuality?=nil) {
        self.ozone = ozone?.category.name ?? "Unknown"
        self.ozoneAQI = ozone != nil ? "\(ozone!.AQI)": "-"
        self.primaryPollutant = primary?.category.name ?? "Unknown"
        self.primaryPollutantType = primary?.pollutant ?? "Unknown"
        self.primaryPollutantAQI = primary != nil ? "\(primary!.AQI)" : "-"
    }
    
    var body: some View {
        VStack(spacing: 13) {
            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 5) {
                    Image(systemName: "sun.dust.fill")
                    
                    Text("Ozone")
                }
                .font(Font.callout.weight(.medium))
                .foregroundColor(determineColor(cat: forecast.forecasts[1].category.number))
                
                HStack(spacing: 0) {
                    Text(ozoneAQI)
                        .font(.title)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                    + Text("ppb")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Text(ozone)
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(Color(.tertiaryLabel))
                }
            }
            .padding(16)
            .background(colorScheme == .dark ? Color(.tertiarySystemFill) : Color(.tertiarySystemBackground).opacity(0.79))
            .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
            .contentShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
        
            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 5) {
                    Image(systemName: "aqi.low")
                    
                    Text("Dominant Pollutant")
                }
                .font(Font.callout.weight(.medium))
                .foregroundColor(determineColor(cat: forecast.forecasts[1].category.number))
                    
                HStack(spacing: 0) {
                    Text("PM")
                        .font(.title)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                    + Text(primaryPollutantAQI)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                
                    Spacer()
                    
                    Text(primaryPollutant)
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(Color(.tertiaryLabel))
                }
            }
            .padding(16)
            .background(colorScheme == .dark ? Color(.tertiarySystemFill) : Color(.tertiarySystemBackground).opacity(0.79))
            .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
            .contentShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
        }
    }
}
