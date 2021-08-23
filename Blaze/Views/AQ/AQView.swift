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
                HStack(spacing: 0) {
                    Text("Air Quality Overview")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    SymbolButton(popup ? "chevron.down" : "chevron.up", Color(.tertiaryLabel))
                }
                .padding(20)
                .contentShape(Rectangle())
            }
            .buttonStyle(DefaultButtonStyle())
            
            if popup {
                aqidata
            }
        }
    }
    
    private var aqidata: some View {
        VStack(spacing: 0) {
            Divider()
                .padding(.horizontal, 20)

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    ZStack {
                        if let color = forecast.forecasts[1].category.number, color != -1 {
                            determineColor(cat: color)
                                .frame(width: 230, height: 230)
                                .clipShape(Circle())
                                .scaleEffect(showCircle ? 1.0 : 0.5)
                                .animation(Animation.easeInOut(duration: 0.7), value: showCircle)
                                .opacity(0.7)
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
                        .padding(.bottom, 20)
                }
            }
        }
    }
}
