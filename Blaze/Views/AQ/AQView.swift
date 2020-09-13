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
                AQMeter(level: forecast.forecasts[1].category.Name, aqi: forecast.aqiPollutant)
                    .padding(.vertical, 45)
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
            }
        }
    }
}

struct AQView_Previews: PreviewProvider {
    static var previews: some View {
        AQView()
    }
}
