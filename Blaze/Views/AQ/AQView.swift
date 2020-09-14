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
                Spacer()
                AQMeter(airQ: forecast.forecasts[1])
                    .scaleEffect(show ? 1 : 0)
                    .onAppear {
                        show = false
                        withAnimation(.spring()) {
                            show = true
                        }
                    }
                Spacer()
                
                Header(title: "Air Quality", desc: "Today’s air quality level is high. The US Forest Service is in unified command with CAL FIRE onthe Elkhorn Fire.")
                    .padding(.bottom, 20)
                
                AQCard(ozone: forecast.forecasts[0], primary: forecast.forecasts[1])
                    .animation(.spring())
            }
        }
    }
}
