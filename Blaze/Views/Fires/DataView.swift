//
//  DataView.swift
//  Blaze
//
//  Created by Paul Wong on 9/14/20.
//

import SwiftUI

struct DataView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Data integrity is crucial for wildfire awareness. In order to deliver the most current fire status, government sources are used. \n\nWildfire data is taken from fire.ca.gov. Information presented in the app is a representation of the existing wildfire situation, based on the information readily available to CAL FIRE. Such data comes from the firelines and must be approved by the Incident Commander in charge of managing the incident prior to release. As battling fires, or handling any other disaster is the priority, updates to these sites cannot be guaranteed on a set time schedule. Please use the information on Blaze only as a reference. This app is not meant to provide up to the minute evacuation or fire behavior information. \n\nPlease refer to the fire information phone numbers provided, website links, and monitor your local radio stations for emergency broadcasts.")
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 20)
        }
        .navigationBarTitle("Data", displayMode: .large)
    }
}
