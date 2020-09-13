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
        VStack(spacing: 10) {
            Text(level)
                .font(.largeTitle)
                .fontWeight(.bold)
            (
                Text(aqi) + Text(" AQI")
            )
            .font(.system(size: 20))
            .fontWeight(.bold)
            .opacity(0.5)
                
        }
        .foregroundColor(.white)
        .padding(75)
        .background(Color.blaze)
        .clipShape(Circle())
    }
}

struct AQMeter_Previews: PreviewProvider {
    static var previews: some View {
        AQMeter(level: "Moderate", aqi: "100")
    }
}
