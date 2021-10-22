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
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 5) {
                    HStack(spacing: 5) {
                        Image(systemName: "sun.dust.fill")
                        
                        Text("Ozone")
                    }
                    .font(Font.callout.weight(.medium))
                    .foregroundColor(determineColor(cat: forecast.forecasts[1].category.number))
                    
                    Text(ozone)
                        .font(.title)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                }
                
                Spacer()

                Text(ozoneAQI)
                    .foregroundColor(.secondary)
                    .fontWeight(.medium)
                    .font(.subheadline)
            }
            .padding(16)
            .background(colorScheme == .dark ? Color(.tertiarySystemFill) : Color(.tertiarySystemBackground).opacity(0.79))
            .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
            .contentShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
            
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 5) {
                    HStack(spacing: 5) {
                        Image(systemName: "aqi.low")
                        
                        Text("Particulate Matter")
                    }
                    .font(Font.callout.weight(.medium))
                    .foregroundColor(determineColor(cat: forecast.forecasts[1].category.number))
                    
                    Text(primaryPollutant + " ")
                        .font(.title)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                    + Text(primaryPollutantType)
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundColor(Color(.tertiaryLabel))
                }
                
                Spacer()

                Text(primaryPollutantAQI)
                    .foregroundColor(.secondary)
                    .fontWeight(.medium)
                    .font(.subheadline)
            }
            .padding(16)
            .background(colorScheme == .dark ? Color(.tertiarySystemFill) : Color(.tertiarySystemBackground).opacity(0.79))
            .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
            .contentShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
        }
        .padding(.horizontal, 20)
    }
}
