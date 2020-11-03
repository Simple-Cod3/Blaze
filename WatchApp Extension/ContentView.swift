//
//  ContentView.swift
//  WatchApp Extension
//
//  Created by Nathan Choi on 11/2/20.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var forecast: AirQualityBackend
    @State private var showCircle = false
    @State private var show = false
    
    var body: some View {
        ScrollView {
        ZStack {
            if let color = forecast.forecasts[1].category.number, color != -1 {
                determineColor(cat: color)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .scaleEffect(showCircle ? 1.0 : 0)
                    .animation(Animation.easeInOut(duration: 0.7), value: showCircle)
                    .opacity(0.7)
            }
            
            AQMeter(airQ: forecast.forecasts[1])
                .scaleEffect(showCircle ? 1.0 : 0)
                .onAppear {
                    withAnimation(nil) { showCircle = false }
                    forecast.refreshForecastList()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation(.spring(dampingFraction: 0.8)) {
                            showCircle = true
                            show = true
                        }
                    }
                }
            }
        .padding(.top, 20)
        }
        .navigationTitle("Air Quality")
    }
}

struct AQMeter: View {
    var airQ: AirQuality
    
    var body: some View {
        VStack(spacing: 10) {
            if String(airQ.AQI) == "-1" {
                ProgressView()
            } else {
                Text(airQ.category.name)
                    .font(airQ.category.name.count > 10 ? .caption : .title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                (Text(String(airQ.AQI)) + Text(" AQI"))
                    .font(.title3)
                    .fontWeight(.regular)
                    .opacity(0.7)
                    .transition(.opacity)
                    .animation(.easeInOut)
            }
        }
        .foregroundColor(.white)
        .padding(25)
        .animation(.spring())
        .background(determineColor(cat: airQ.category.number))
        .clipShape(Circle())
    }
}

func determineColor(cat: Int) -> Color {
    switch cat {
    case 1:
        return Color.green
    case 2:
        return Color.yellow
    case 3:
        return Color.red
    case 4:
        return Color.purple
    default:
        return Color.blaze
    }
}

struct AQMeter_Previews: PreviewProvider {
    static var previews: some View {
        AQMeter(airQ: AirQuality())
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
