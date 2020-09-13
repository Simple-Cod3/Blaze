//
//  AQCard.swift
//  Blaze
//
//  Created by Paul Wong on 9/9/20.
//

import SwiftUI

struct AQCard: View {
    
    var forecastData: Forecast
    var date: String
    var ozone: String
    var ozoneCaption: String
    var primaryPollutant: String
    var primaryPollutantCaption: String
    
    init (forecast: Forecast){
        self.forecastData = forecast
        self.date = forecast.dateForecast
        self.ozone = forecast.category.Name //not actual ozone just place holder
        self.ozoneCaption = forecast.place
        self.primaryPollutant = forecast.pollutant
        self.primaryPollutantCaption = forecast.pollutant
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(date)
                .font(.system(size: 30))
                .fontWeight(.bold)
                .opacity(0.5)
                
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("Ozone")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                    
                    Text(ozone)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                
                Spacer()
                
                Text(ozoneCaption)
                    .font(.body)
                    .fontWeight(.semibold)
                    .opacity(0.5)
            }
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("Primary Pollutant")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                    
                    Text(primaryPollutant)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                
                Spacer()
                
                Text(primaryPollutantCaption)
                    .font(.body)
                    .fontWeight(.semibold)
                    .opacity(0.5)
            }
        }
        .padding(15)
        .foregroundColor(.white)
        .background(Color.blaze)
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        .padding(.horizontal, 20)
    }
}
/*
struct AQCard_Previews: PreviewProvider {
    static var previews: some View {
        Forecast forecast = Forecast()
        
        AQCard(date: "Today", ozone: "22", ozoneCaption: "Good. Enjoy your outdoor activities.", primaryPollutant: "2.5", primaryPollutantCaption: "Restrain from going outdoors.")
 
    }
 
}
*/
