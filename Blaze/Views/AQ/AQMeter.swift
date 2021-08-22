//
//  AQMeter.swift
//  Blaze
//
//  Created by Paul Wong on 9/9/20.
//

import SwiftUI

struct AQMeter: View {
    
    var airQ: AirQuality
    
    var body: some View {
        VStack(spacing: 5) {
            if String(airQ.AQI) == "-1" {
                ProgressView()
            } else {
                Text(airQ.category.name)
                    .font(airQ.category.name.count > 10 ? .callout : .title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                
                (Text(String(airQ.AQI)) + Text(" AQI"))
                    .font(.headline)
                    .opacity(0.7)
                    .transition(.opacity)
                    .animation(.easeInOut)
            }
        }
        .foregroundColor(.white)
        .padding(75)
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
