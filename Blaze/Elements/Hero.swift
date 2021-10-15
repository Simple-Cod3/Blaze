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
        .padding(20)
        .background(background)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .padding(20)
    }
}

struct HeroCard: View {
        
    @EnvironmentObject var fireB: FireBackend
    @EnvironmentObject var forecast: AirQualityBackend
    
    private var page: Int
    
    init(_ page: Int) {
        self.page = page
    }

    var body: some View {
        switch page {
        case 0:
            Hero(
                "flame",
                "Wildfires",
                "Showing \(fireB.fires.count) incidents.",
                Color.blaze
            )
        case 1:
            Hero(
                "aqi.medium",
                "Air Quality",
                !forecast.lost ? "Showing air quality in \(forecast.forecasts.first!.place)" + "." : "Unable to obtain device location.",
                determineColor(cat: forecast.forecasts[1].category.number)
            )
        case 2:
            Hero(
                "newspaper",
                "News",
                "Latest national news and updates.",
                Color.orange
            )
        default:
            Hero(
                "flame",
                "Wildfires",
                "Showing \(fireB.fires.count) hotspots across the United States.",
                Color.blaze
            )
        }
    }
}
