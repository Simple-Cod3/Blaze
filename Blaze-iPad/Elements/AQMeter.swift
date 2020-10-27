//
//  AQMeter.swift
//  Blaze-iPad
//
//  Created by Paul Wong on 10/27/20.
//

import SwiftUI

struct AQMeter: View {
    var airQ: AirQuality
    
    var body: some View {
        VStack(spacing: 10) {
            if String(airQ.AQI) == "-1" {
                ProgressView()
            } else {
                Text(airQ.category.name)
                    .font(airQ.category.name.count > 10 ? .body : .largeTitle)
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
        .padding(150)
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
