//
//  InfoCard.swift
//  Blaze
//
//  Created by Paul Wong on 9/4/20.
//

import SwiftUI

struct InfoCard: View {
    var name: String
    var location: String
    var acres: String
    var containment: String
    var updated: String
    var cause: String
    var started: String
    
    init(_ name: String, location: String, acres: String, containment: String, updated: String, cause: String, started: String) {
        self.name = name
        self.location = location
        self.acres = acres
        self.containment = containment
        self.updated = updated
        self.cause = cause
        self.started = started
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "flame.fill")
                    .font(.system(size: 30))
                    .opacity(0.25)
                
                Spacer()
                
                TestButton(text: "NEXT")
            }
            .padding(.bottom, 10)
            
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(name)
                        .font(.title)
                        .fontWeight(.bold)
                        .opacity(0.75)
                    
                    Text(location)
                        .font(.body)
                        .fontWeight(.semibold)
                        .opacity(0.25)
                        .padding(.bottom, 30)
                    
                    Text(acres)
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.orange)
                    
                    Text(containment)
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.orange)
                }
                Spacer()
                VStack(alignment: .leading, spacing: 25) {
                    Text(updated)
                        .font(.body)
                        .fontWeight(.semibold)
                    
                    Text(cause)
                        .font(.body)
                        .fontWeight(.semibold)
                    
                    Text(started)
                        .font(.body)
                        .fontWeight(.semibold)
                    
                }
                .foregroundColor(.orange)
            }
        }
        .padding(20)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(15)
        .padding(.horizontal, 20)

    }
}

struct InfoCard_Previews: PreviewProvider {
    static var previews: some View {
        InfoCard("Elkhorn Fire", location: "Tomhead Mountain \narea, west of Red Bluff", acres: "39,995 Acres", containment: "40% Contained", updated: "9/1/2020, \n9:35:12 AM", cause: "Lightning", started: "8/17/2020, \n9:33 AM")
    }
}
