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
        VStack(spacing: 3) {
            if String(airQ.AQI) == "-1" {
                ProgressView()
            } else {
                Text(airQ.category.name)
                    .font(airQ.category.name.count > 10 ? .callout : .title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                
                (Text(String(airQ.AQI)) + Text(" AQI"))
                    .font(.body)
                    .fontWeight(.medium)
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
        return Color.gray
    }
}

func determineInt(cat: Int) -> Double {
    switch cat {
    case 1:
        return 1.3
    case 2:
        return 0.7
    case 3:
        return 0.3
    case 4:
        return 0.1
    default:
        return 1.3
    }
}
