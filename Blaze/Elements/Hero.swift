//
//  Hero.swift
//  Hero
//
//  Created by Paul Wong on 8/19/21.
//

import SwiftUI

struct Hero: View {
    
    private var symbol: String
    private var title: String
    private var desc: String
    private var background: Color
    
    init(_ symbol: String, _ title: String, _ desc: String, _ background: Color) {
        self.symbol = symbol
        self.title = title
        self.desc = desc
        self.background = background
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(spacing: 5) {
                Image(systemName: symbol)
                    .font(Font.body.weight(.medium))
                    .foregroundColor(.white)

                Header(title)
                
                Spacer()
            }
            
            Text(desc)
            .font(.subheadline)
            .foregroundColor(.white.opacity(0.7))
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding(20)
        .background(background)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .padding(20)
    }
}

//VStack(alignment: .leading, spacing: 5) {
//    HStack(spacing: 5) {
//        Image(systemName: wildfire ? "flame" : aqi ? "aqi.medium" : "newspaper")
//            .font(Font.body.weight(.medium))
//            .foregroundColor(.white)
//
//        Header(
//            wildfire ? "Wildfires" : aqi ? "Air Quality" : "News"
//        )
//
//        Spacer()
//
//        Text("See More")
//            .font(.subheadline)
//            .fontWeight(.medium)
//            .foregroundColor(.white.opacity(1))
//
//        Image(systemName: "arrowtriangle.down.fill")
//            .font(.caption)
//            .foregroundColor(.white.opacity(1))
//    }
//
//    Text(
//        wildfire ? "Showing 390 hotspots across the United States." :
//        aqi ? (!forecast.lost ? "Displaying air quality in \(forecast.forecasts.first!.place)" + "." : "Unable to obtain device location.") :
//            "Latest national news and updates issued by the Incident Information System."
//    )
//    .font(.subheadline)
//    .foregroundColor(.white.opacity(0.7))
//}
//.fixedSize(horizontal: false, vertical: true)
//.padding(20)
//.background(
//    wildfire ? Color.blaze : aqi ? determineColor(cat: forecast.forecasts[1].category.number) : Color.orange
//)
//.clipShape(RoundedRectangle(cornerRadius: 16, style
