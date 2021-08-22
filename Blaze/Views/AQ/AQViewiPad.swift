//
//  AQViewiPad.swift
//  Blaze
//
//  Created by Paul Wong on 11/2/20.
//

import SwiftUI

struct AQViewiPad: View {
    
    @EnvironmentObject var forecast: AirQualityBackend
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
//                    Header(
//                        title: "Air Quality",
//                        desc: !forecast.lost ? "Currently displaying air quality in \(forecast.forecasts.first!.place)" + "." : "Cannot get the location of your device. Showing air quality in San Francisco.",
//                        headerColor: determineColor(cat: forecast.forecasts[1].category.number)
//                    )
                    
                    AQCardiPad(ozone: forecast.forecasts[0], primary: forecast.forecasts[1])
                    
                    Caption("Ozone (O3) is harmful to air quality at ground level. PM values indicate the diameter of particulate matter measured in microns. \n\nAir quality data is provided by the AirNow.gov. See more at AirNow.gov")
                }
            }
            .padding(.top, 20)
            .background(Color(.secondarySystemBackground))
            .navigationBarTitle("", displayMode: .inline)
            
            VStack {
                Spacer()
                
                ZStack {
                    if let color = forecast.forecasts[1].category.number, color != -1 {
                        determineColor(cat: color)
                            .frame(width: 370, height: 370)
                            .clipShape(Circle())
                            .opacity(0.7)
                    }
                    
                    AQMeteriPad(airQ: forecast.forecasts[1])
                        .padding(.vertical, 75)
                }
                
                Spacer()
            }
            .navigationBarTitle("Air Quality", displayMode: .inline)
        }
    }
}
