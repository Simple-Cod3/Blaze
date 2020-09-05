//
//  InfoCard.swift
//  Blaze
//
//  Created by Paul Wong on 9/4/20.
//

import SwiftUI
import ModalView

struct InfoCard: View {
    @Binding var hide: Bool
    
    var fireData: ForestFire
    var name: String
    var locations: String
    var acres: String
    var containment: String
    var updated: String
    var started: String
    
    init(fire: ForestFire, hide: Binding<Bool>) {
        self._hide = hide
        self.fireData = fire
        
        self.name = fire.name
        self.locations = fire.getLocation()
        self.acres = fire.getAreaString()
        self.containment = "\(fire.contained)% Contained"
        self.updated = "\(fire.updated.getDateTime())"
        self.started = "\(fire.start.getDateTime())"
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "flame.fill")
                    .font(.system(size: 30))
                    .opacity(0.25)
                
                Spacer()
                
                ModalLink(destination: {
                    InformationView(dismiss: $0, fireData: fireData)
                }) {
                    InfoButton(text: "INFO")
                }.buttonStyle(PlainButtonStyle())
                
            }.padding(.bottom, 10)
            
            if hide {
                Spacer()
            } else {
                Text(name)
                    .font(.title)
                    .fontWeight(.bold)
                    .opacity(0.75)
                    .padding(.bottom, 5)
                
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(locations)
                            .font(.body)
                            .fontWeight(.semibold)
                            .opacity(0.25)
                            .padding(.bottom, 30)
                            .fixedSize(horizontal: false, vertical: true)
                        
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
                        HStack(alignment: .top, spacing: 3) {
                            Image(systemName: "calendar.badge.exclamationmark")
                                .padding(.top, 3)
                            Text(updated)
                                .font(.body)
                                .fontWeight(.semibold)
                        }
                        
                        HStack(alignment: .top, spacing: 3) {
                            Image(systemName: "livephoto.play")
                                .padding(.top, 3)
                            Text(started)
                                .font(.body)
                                .fontWeight(.semibold)
                        }
                        
                        
                    }
                    .foregroundColor(.orange)
                }
            }
        }
            .frame(minHeight: 280)
            .padding(20)
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(15)
            .padding(.horizontal, 20)

    }
}

