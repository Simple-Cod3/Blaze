//
//  AQView.swift
//  Blaze
//
//  Created by Paul Wong on 9/9/20.
//

import SwiftUI

struct AQView: View {
    @EnvironmentObject var forecast: AirQualityBackend
    @State var show = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                AQMeter(airQ: forecast.forecasts[1])
                    .padding(.vertical, 50)
                    .scaleEffect(show ? 1.0 : 0)
                    .onAppear {
                        forecast.refreshForecastList()
                        withAnimation(nil) { show = false }
                        withAnimation(.spring()) { show = true }
                    }
                
                Header(
                    title: "Air Quality",
                    desc: !forecast.lost ? "Currently displaying air quaility in \(forecast.forecasts.first!.place)" : "Cannot get the location of your device. Showing air quality in San Francisco."
                )
                    .padding(.bottom, 20)
                
                AQCard(ozone: forecast.forecasts[0], primary: forecast.forecasts[1])
                
                HStack {
                    Text("Ozone (O3) is harmful to air quality at ground level. PM values indicate the diameter of particulate matter measured in microns. \n\nAir quality data is provided by the AirNow.gov. See more at airnow.gov.")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                        .padding([.horizontal, .bottom], 20)
                    Spacer()
                }
            }
        }
    }
}
