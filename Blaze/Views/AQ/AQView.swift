//
//  AQView.swift
//  Blaze
//
//  Created by Paul Wong on 9/9/20.
//

import SwiftUI

struct AQView: View {
    @EnvironmentObject var forecast: AirQualityBackend
    @State private var showCircle = false
    @State private var show = false
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(showsIndicators: false) {
                VStack {
                    ZStack {
                        if let color = forecast.forecasts[1].category.Number,
                           color != -1
                        {
                            determineColor(cat: color)
                                .frame(width: 270, height: 270)
                                .clipShape(Circle())
                                .scaleEffect(showCircle ? 1.0 : 0.5)
                                .animation(Animation.easeInOut(duration: 0.7), value: showCircle)
                                .opacity(0.7)
                        }
                        
                        AQMeter(airQ: forecast.forecasts[1])
                            .padding(.vertical, 75)
                            .scaleEffect(showCircle ? 1.0 : 0)
                            .onAppear {
                                forecast.refreshForecastList()
                                withAnimation(nil) { showCircle = false }
                                withAnimation(.spring(dampingFraction: 0.8)) {
                                    showCircle = true
                                    show = true
                                }
                            }
                    }
                    
                    Header(
                        title: "Air Quality",
                        desc: !forecast.lost ? "Currently displaying air quaility in \(forecast.forecasts.first!.place)" : "Cannot get the location of your device. Showing air quality in San Francisco.",
                        headerColor: determineColor(cat: forecast.forecasts[1].category.Number)
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
                .opacity(show ? 1 : 0)
            StatusBg()
        }
    }
}
