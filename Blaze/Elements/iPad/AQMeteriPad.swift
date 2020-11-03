//
//  AQMeteriPad.swift
//  Blaze
//
//  Created by Paul Wong on 11/2/20.
//

import SwiftUI

struct AQMeteriPad: View {
    var airQ: AirQuality
    
    var body: some View {
        VStack(spacing: 10) {
            if String(airQ.AQI) == "-1" {
                ProgressView()
            } else {
                Text(airQ.category.name)
                    .font(airQ.category.name.count > 10 ? .title3 : .largeTitle)
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
        .padding(135)
        .animation(.spring())
        .background(determineColor(cat: airQ.category.number))
        .clipShape(Circle())
    }
}
