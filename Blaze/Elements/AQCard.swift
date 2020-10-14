//
//  AQCard.swift
//  Blaze
//
//  Created by Paul Wong on 9/9/20.
//

import SwiftUI

struct AQCard: View {
    private var date: String
    private var ozone: String
    private var ozoneCaption: String
    private var primaryPollutant: String
    private var primaryPollutantCaption: String
    
    init (ozone: AirQuality, primary: AirQuality){
        self.date = ozone.getDate()
        self.ozone = ozone.category.Name
        self.ozoneCaption = ozone.pollutant
        self.primaryPollutant = primary.category.Name
        self.primaryPollutantCaption = primary.pollutant
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(date)
                .font(.system(size: 30))
                .fontWeight(.medium)
                .foregroundColor(.secondary)

            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("Ozone")
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                    
                    Text(ozone)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                }
                
                Spacer()
                
                Text(ozoneCaption)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
            }
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("Particulate Matter")
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                    
                    Text(primaryPollutant)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                }
                
                Spacer()
                
                Text(primaryPollutantCaption)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
            }
        }
        .padding(15)
        .foregroundColor(.primary)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        .padding([.bottom, .horizontal], 20)
    }
}
