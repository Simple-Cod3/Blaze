//
//  AQCard.swift
//  Blaze-iPad
//
//  Created by Paul Wong on 10/27/20.
//

import SwiftUI

struct AQCard: View {
    private var date: String
    private var ozone: String
    private var ozoneCaption: String
    private var primaryPollutant: String
    private var primaryPollutantCaption: String
    
    init (ozone: AirQuality, primary: AirQuality) {
        self.date = ozone.getDate()
        self.ozone = ozone.category.name
        self.ozoneCaption = ozone.pollutant
        self.primaryPollutant = primary.category.name
        self.primaryPollutantCaption = primary.pollutant
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(date)
                .font(.largeTitle)
                .fontWeight(.medium)
                .foregroundColor(.secondary)

            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("Ozone")
                        .font(.title3)
                        .fontWeight(.regular)
                        .foregroundColor(.secondary)
                    
                    Text(ozone)
                        .font(.largeTitle)
                        .fontWeight(.medium)
                }
                
                Spacer()
                
                Text(ozoneCaption)
                    .font(.title3)
                    .fontWeight(.regular)
                    .foregroundColor(.secondary)
            }
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("Particulate Matter")
                        .font(.title3)
                        .fontWeight(.regular)
                        .foregroundColor(.secondary)
                    
                    Text(primaryPollutant)
                        .font(.largeTitle)
                        .fontWeight(.medium)
                }
                
                Spacer()
                
                Text(primaryPollutantCaption)
                    .font(.title3)
                    .fontWeight(.regular)
                    .foregroundColor(.secondary)
            }
        }
        .padding(15)
        .foregroundColor(.primary)
        .background(Color(.tertiarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        .padding([.bottom, .horizontal], 20)
    }
}
