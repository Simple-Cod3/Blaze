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
            Header(title: "Data", desc: "Data analysis is crucial for wildfire awareness. In Blaze, to have the most current fire status, online sources and databases are used.")
                .padding(.vertical, 20)
            
            Text("Data for Blaze is taken from fire.ca.gov. Information presented in the app is a representation of the existing wildfire situation, based on the information readily available to CAL FIRE. Such data comes from the firelines and must be approved by the Incident Commander in charge of managing the incident prior to release. As battling a fire, or handling any other disaster is the priority, updates to these sites cannot be guaranteed on a set time schedule. Please use the information on Blaze only as a reference. This app is not meant to provide up to the minute evacuation or fire behavior information. \n\nPlease refer to the fire information phone numbers provided in your area, and website links for additional information, and monitor your local radio stations for emergency broadcasts.")
                .fontWeight(.medium)
                .foregroundColor(.secondary)
                .padding(20)
        }
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView()
    }
}
