//
//  AQCard.swift
//  Blaze
//
//  Created by Paul Wong on 9/9/20.
//

import SwiftUI

struct AQCard: View {
    
    @EnvironmentObject var forecast: AirQualityBackend
    
    private var ozone: String
    private var ozoneCaption: String
    private var primaryPollutant: String
    private var primaryPollutantCaption: String
    
    init (ozone: AirQuality, primary: AirQuality) {
        self.ozone = ozone.category.name
        self.ozoneCaption = ozone.pollutant
        self.primaryPollutant = primary.category.name
        self.primaryPollutantCaption = primary.pollutant
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
            }
            .padding(16)
            .background(Color(.quaternarySystemFill))
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
                    + Text(primaryPollutantCaption)
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundColor(Color(.tertiaryLabel))
                }
                
                Spacer()
            }
            .padding(16)
            .background(Color(.quaternarySystemFill))
            .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
            .contentShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
        }
        .padding(.horizontal, 20)
    }
}
