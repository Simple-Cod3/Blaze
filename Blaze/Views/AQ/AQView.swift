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
        print(forecast.forecasts)
        
        return ScrollView(showsIndicators: false) {
            VStack {
                AQMeter(airQ: forecast.forecasts[1])
                    .padding(.vertical, 50)
                    .scaleEffect(show ? 1 : 0)
                    .onAppear {
                        show = false
                        withAnimation(.spring()) {
                            show = true
                        }
                    }
                
                Header(title: "Air Quality", desc: "Today’s air quality level is high. The US Forest Service is in unified command with CAL FIRE onthe Elkhorn Fire.")
                    .padding(.bottom, 20)
                
                AQCard(ozone: forecast.forecasts[0], primary: forecast.forecasts[1])
                
                Text("Air quality data is provided by the AirNow API. See more at airnow.gov.")
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                    .padding([.horizontal, .bottom], 20)
            }
        }
    }
}
