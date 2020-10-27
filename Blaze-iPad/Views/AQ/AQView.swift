//
//  AQView.swift
//  Blaze-iPad
//
//  Created by Paul Wong on 10/27/20.
//

import SwiftUI

struct AQView: View {
    @EnvironmentObject var forecast: AirQualityBackend
    @State private var showCircle = false
    @State private var show = false
    
    var body: some View {
        HStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    Spacer()
                    HStack {
                        Header(
                            title: "Air Quality",
                            desc: !forecast.lost ? "Currently displaying air quality in \(forecast.forecasts.first!.place)" + "." : "Cannot get the location of your device. Showing air quality in San Francisco.",
                            headerColor: determineColor(cat: forecast.forecasts[1].category.number)
                        )
                    }
                    .padding(.bottom, 20)
                    AQCard(ozone: forecast.forecasts[0], primary: forecast.forecasts[1])
                    
                    HStack {
                        Text("Ozone (O3) is harmful to air quality at ground level. PM values indicate the diameter of particulate matter measured in microns. \n\nAir quality data is provided by the AirNow.gov. See more at ")
                            .font(.caption)
                            .fontWeight(.regular)
                            .foregroundColor(.secondary)
                        + Text("AirNow.gov")
                            .font(.caption)
                            .fontWeight(.regular)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 80)
                }
                .frame(height: UIScreen.main.bounds.height)
            }
            .frame(width: UIScreen.main.bounds.width/3)
            .background(Color(.secondarySystemBackground))
            
            Spacer()
            
            ZStack {
                if let color = forecast.forecasts[1].category.number, color != -1 {
                    determineColor(cat: color)
                        .frame(width: 415, height: 415)
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
            .padding(.bottom, 60)
            Spacer()
            
            
            
            
            
        }
        .edgesIgnoringSafeArea(.all)
    }
}
