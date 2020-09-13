//
//  AQView.swift
//  Blaze
//
//  Created by Paul Wong on 9/9/20.
//

import SwiftUI

struct AQView: View {
    @EnvironmentObject var forecast: ForecastBackend
    var body: some View {
        VStack {
            AQMeter(level: "Moderate", aqi: "100")
                .padding(.vertical, 45)
            
            
            Header(title: "Air Quality", desc: "Today’s air quality level is high. The US Forest Service is in unified command with CAL FIRE onthe Elkhorn Fire.")
                .padding(.bottom, 20)
            
            AQCard(forecast: forecast.forecasts[0])
        }
    }
}

struct AQView_Previews: PreviewProvider {
    static var previews: some View {
        AQView()
    }
}
