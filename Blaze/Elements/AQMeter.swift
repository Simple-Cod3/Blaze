//
//  AQMeter.swift
//  Blaze
//
//  Created by Paul Wong on 9/9/20.
//

import SwiftUI

struct AQMeter: View {
    var level: String
    var aqi: String
    
    var body: some View {
        print(aqi)
        
        return VStack(spacing: 10) {
            if aqi == "-1" {
                ProgressView().foregroundColor(.white)
            } else {
                Text(level)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                (Text(aqi) + Text(" AQI"))
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .opacity(0.5)
            }
        }
            .foregroundColor(.white)
            .padding(75)
            .animation(.spring())
            .background(determineColor(aqi: aqi))
            .clipShape(Circle())
    }
}


func determineColor(aqi: String? = "0") -> Color{
    switch (aqi) {
    case "1":
        return Color.green
    case "2":
        return Color.yellow
    case "3":
        return Color.red
    case "4":
        return Color.purple
    default:
        return Color.pink
    }
}

struct AQMeter_Previews: PreviewProvider {
    static var previews: some View {
        AQMeter(level: "Moderate", aqi: "100")
    }
}
