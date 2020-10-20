//
//  InfoCard.swift
//  Blaze
//
//  Created by Paul Wong on 9/4/20.
//

import SwiftUI
import ModalView

struct MapFireCard: View {
    @Binding var hide: Bool
    @Binding var show: Bool
    @State private var random = false
    
    private var fireData: ForestFire
    private var name: String
    private var locations: String
    private var acres: String
    private var containment: String
    private var updated: String
    private var started: String
    
    init(fire: ForestFire, hide: Binding<Bool>, show: Binding<Bool>) {
        self._hide = hide
        self._show = show
        self.fireData = fire
        
        self.name = fire.name
        self.locations = fire.getLocation()
        self.acres = fire.getAreaString()
        self.containment = "\(fire.getContained()) Contained"
        self.updated = "\(fire.updated.getDateTime())"
        self.started = "\(fire.started.getDateTime())"
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "flame")
                    .foregroundColor(.blaze)
                    .font(.system(size: 30))
                
                Spacer()
                
                Button(action: {
                    show.toggle()
                }) {
                    InfoButton()
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            if hide {
                
            } else {
                Spacer().frame(height: 15)
                Text(name)
                    .font(.title)
                    .fontWeight(.medium)
                    .padding(.bottom, 5)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(locations)
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 30)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text(acres)
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(.blaze)
                    
                    Text(containment)
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(.blaze)
                }
            }
        }
        .frame(minHeight: hide ? 0 : 200)
        .padding(20)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(15)
        .padding(.horizontal, 20)
    }
}

