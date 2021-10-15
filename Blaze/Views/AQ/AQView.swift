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

    var body: some View {
        VStack(spacing: 0) {
            Button(action: {
                UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) { popup.toggle() }
            }) {
                HeaderButton("Air Quality Overview", popup ? "chevron.down" : "chevron.up")
            }
            .buttonStyle(DefaultButtonStyle())
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onEnded({ value in
                    withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) {
                        popup = value.translation.height > 0 ? false : true
                    }
                }))
            
            if popup {
                aqidata
            }
        }
    }
    
    private var aqidata: some View {
        VStack(spacing: 0) {
            Divider()
                .padding(.horizontal, 20)

            ScrollView {
                VStack(spacing: 0) {
                    ZStack {
                        if let color = forecast.forecasts[1].category.number, color != -1 {
                            determineColor(cat: color)
                                .frame(width: 220, height: 220)
                                .clipShape(Circle())
                                .scaleEffect(showCircle ? 1 : 0.5)
                                .animation(Animation.spring(response: 1.1, dampingFraction: 1), value: showCircle)
                                .opacity(0.7)
                                .scaleEffect(startAnimation ? 1 : 1.05)
                                .animation(Animation.easeInOut(duration: 2).delay(determineInt(cat: forecast.forecasts[1].category.number))
                                        .repeatForever(autoreverses: true), value: startAnimation)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { startAnimation = true }
                                }
                                .onDisappear {
                                    startAnimation = false
                                }
                        }
                        
                        AQMeter(airQ: forecast.forecasts[1])
                            .padding(.vertical, 60)
                            .scaleEffect(showCircle ? 1.0 : 0)
                            .onAppear {
                                forecast.refreshForecastList()
                                withAnimation(nil) { showCircle = false }
                                withAnimation(.spring(dampingFraction: 0.8)) {
                                    showCircle = true
                                }
                            }
                    }
                    
                    AQCard(ozone: forecast.forecasts[0], primary: forecast.forecasts[1])
                        .padding(.bottom, 13)
                    
                    Caption("Ozone is harmful to air quality at ground level. \n\nPM values indicate the diameter of particulate matter measured in microns. \n\nAir quality data is provided by the AirNow.gov. See more at AirNow.gov")
                        .padding([.horizontal, .bottom], 20)
                }
            }
        }
    }
}
