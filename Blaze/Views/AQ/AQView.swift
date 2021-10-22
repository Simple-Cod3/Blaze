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
    @State private var startAnimation = false
    
    @Binding var popup: Bool
    
    init(popup: Binding<Bool>) {
        self._popup = popup
    }
    
    func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
        return UIFont.preferredFont(forTextStyle: textStyle).pointSize
    }

    var body: some View {
        VStack(spacing: 0) {
            HeaderButton("Air Quality Overview")
                .padding(.bottom, popup ? 0 : UIConstants.bottomPadding+UIScreen.main.bounds.maxY*0.85)
            
            if popup {
                aqidata
            }
        }
    }
    
    private var aqidata: some View {
        VStack(spacing: 0) {
            Divider()
                .padding(.horizontal, UIConstants.margin)

            ScrollView {
                VStack(spacing: 0) {
                    ZStack {
                        if let color = forecast.forecasts[0].category.number, color != -1 {
                            determineColor(cat: color)
                                .frame(width: 220, height: 220)
                                .clipShape(Circle())
                                .scaleEffect(showCircle ? 1 : 0.5)
                                .animation(Animation.spring(response: 1.1, dampingFraction: 1), value: showCircle)
                                .opacity(0.7)
                                .scaleEffect(startAnimation ? 1 : 1.05)
                                .animation(Animation.easeInOut(duration: 2).delay(determineInt(cat: forecast.forecasts[0].category.number))
                                        .repeatForever(autoreverses: true), value: startAnimation)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { startAnimation = true }
                                }
                                .onDisappear {
                                    startAnimation = false
                                }
                        }
                        
                        AQMeter(airQ: forecast.forecasts[0])
                            .padding(.vertical, 60)
                            .scaleEffect(showCircle ? 1.0 : 0)
                            .onAppear {
                                withAnimation(nil) { showCircle = false }
                                withAnimation(.spring(dampingFraction: 0.8)) {
                                    showCircle = true
                                }
                            }
                    }
                    
                    AQCard(ozone: forecast.forecasts.filter { $0.pollutant == "O3" }.first, primary: forecast.forecasts.filter { $0.pollutant == "PM2.5" }.first)
                        .padding(.bottom, 13)
                    
                    Caption("Ozone is harmful to air quality at ground level. \n\nPM values indicate the diameter of particulate matter measured in microns. \n\nAir quality data is provided by the AirNow.gov. See more at AirNow.gov")
                }
                .padding([.horizontal, .bottom], UIConstants.margin)
                .padding(.bottom, UIConstants.bottomPadding)
                .padding(.bottom, (textSize(textStyle: .largeTitle)*4))
            }
        }
    }
}
