//
//  AQCard.swift
//  Blaze
//
//  Created by Paul Wong on 9/9/20.
//

import SwiftUI

struct AQData: View {
    
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
            AQCard(
                symbol: "sun.dust.fill",
                title: "Ozone",
                status: ozone,
                caption: "Ozone is found high in Earth's atmosphere, and prevents ultraviolet (UV) radiation from reaching the Earth. However, ozone found low to the ground can damage lungs, causing respiratory problems.",
                foreground: determineColor(cat: forecast.forecasts[1].category.number)
            ) {
                Text(ozoneAQI)
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                + Text(" AQI")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
            }
        
            AQCard(
                symbol: "aqi.low",
                title: "PM2.5",
                status: primaryPollutant,
                caption: "PM2.5 (particulate matter 2.5) is a measure of particle diameters less than or equal to 2.5 microns in the air.",
                foreground: determineColor(cat: forecast.forecasts[1].category.number)
            ) {
                Text(primaryPollutantAQI)
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                + Text(" AQI")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
            }
        }
    }
}
