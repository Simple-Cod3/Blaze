//
//  AQView.swift
//  Blaze
//
//  Created by Paul Wong on 9/9/20.
//

import SwiftUI
import BetterSafariView

struct AQView: View {
    
    @EnvironmentObject var forecast: AirQualityBackend
    
    @State private var showCircle = false
    @State private var startAnimation = false
    @State private var showWebPage = false
    
    @Binding var popup: Bool
    
    init(popup: Binding<Bool>) {
        self._popup = popup
    }
    
    func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
        return UIFont.preferredFont(forTextStyle: textStyle).pointSize
    }

    var body: some View {
        VStack(spacing: 0) {
            HeaderButton(symbol: "aqi.medium", title: "Air Quality")

            Divider()
                .padding(.horizontal, UIConstants.margin)

            ScrollView {
                VStack(spacing: 0) {
                    ZStack {
//                        if let color = forecast.forecasts[0].category.number, color != -1 {
//                            determineColor(cat: color)
//                                .frame(width: 220, height: 220)
//                                .clipShape(Circle())
//                                .scaleEffect(showCircle ? 1 : 0.5)
//                                .animation(Animation.spring(response: 1.1, dampingFraction: 1), value: showCircle)
//                                .opacity(0.7)
//                                .scaleEffect(startAnimation ? 1 : 1.05)
//                                .animation(Animation.easeInOut(duration: 2).delay(determineInt(cat: forecast.forecasts[0].category.number))
//                                        .repeatForever(autoreverses: true), value: startAnimation)
//                                .onAppear {
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { startAnimation = true }
//                                }
//                                .onDisappear {
//                                    startAnimation = false
//                                }
//                        }
                        
                        AQMeter(airQ: forecast.forecasts[0])
                            .padding(.vertical, 60)
                            .scaleEffect(showCircle ? 1.0 : 0.0001)
                            .onAppear {
                                withAnimation(nil) { showCircle = false }
                                withAnimation(.spring(dampingFraction: 0.8)) {
                                    showCircle = true
                                }
                            }
                    }
                    
                    AQData(ozone: forecast.forecasts.filter { $0.pollutant == "O3" }.first, primary: forecast.forecasts.filter { $0.pollutant != "O3" }.first)
                        .padding(.bottom, 13)
                    
                    HStack(spacing: 0) {
                        Text("Air quality data is provided by the AirNow. See more at ")
                            .fontWeight(.regular)
                            .foregroundColor(Color(.tertiaryLabel))
                        + Text("AirNow.gov").underline()
                            .fontWeight(.medium)
                            .foregroundColor(determineColor(cat: forecast.forecasts[1].category.number))
                        
                        Spacer()
                    }
                    .font(.caption)
                    .safariView(isPresented: $showWebPage) {
                        SafariView(
                            url: URL(string: "https://airnow.gov")!,
                            configuration: SafariView.Configuration(
                                barCollapsingEnabled: true
                            )
                        )
                        .preferredControlAccentColor(Color.blaze)
                    }
                    .onTapGesture { showWebPage = true }
                }
                .padding([.horizontal, .bottom], UIConstants.margin)
                .padding(.bottom, UIConstants.bottomPadding)
                .padding(.bottom, (textSize(textStyle: .largeTitle)*4))
            }
        }
    }
}
