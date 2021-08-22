//
//  FireInfoCard.swift
//  Blaze
//
//  Created by Paul Wong on 9/4/20.
//

import SwiftUI
import ModalView

struct FireInfoCard: View {
    
    @State private var random = false
    
    @Binding var popup: Bool
    @Binding var showFireInformation: Bool
    
    private var fireData: ForestFire
    private var name: String
    private var locations: String
    private var acres: String
    private var containment: String
    private var updated: String
    private var started: String
    
    init(popup: Binding<Bool>, showFireInformation: Binding<Bool>, fireData: ForestFire) {
        self._popup = popup
        self._showFireInformation = showFireInformation
        self.fireData = fireData
        self.name = fireData.name
        self.locations = fireData.getLocation()
        self.acres = fireData.getAreaString()
        self.containment = "\(fireData.getContained()) Contained"
        self.updated = "\(fireData.updated.getDateTime())"
        self.started = "\(fireData.started.getDateTime())"
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Button(action: {
                    UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                    withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) { popup.toggle() }
                }) {
                    HStack(spacing: 0) {
                        Image(systemName: "flame")
                            .font(.callout.bold())
                            .foregroundColor(Color.blaze)
                            .padding(.trailing, 5)
                        
                        Text(name)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        SymbolButton(popup ? "chevron.down" : "chevron.up", Color(.tertiaryLabel))
                    }
                }
                .buttonStyle(DefaultButtonStyle())

                Button(action: {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) { showFireInformation = false }
                }) {
                    SymbolButton("xmark", Color(.tertiaryLabel))
                        .padding(.leading, 10)
                }
                .buttonStyle(DefaultButtonStyle())
            }
            .padding(20)
            
            if popup {
                fireinformation
            }
        }
    }
    
    private var fireinformation: some View {
        VStack(spacing: 0) {
            Divider()
                .padding(.horizontal, 20)

            VStack {
                HStack(spacing: 10) {
                    RectButton("Data")
                    RectButton("Information")
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)

                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 5) {
                        Image(systemName: "mappin.circle.fill")
                            .font(.body)
                            .foregroundColor(.primary)

                        Text("Location: ")
                            .foregroundColor(.primary)
                        + Text(locations)
                            .foregroundColor(.secondary.opacity(0.7))
                        
                        Spacer()
                    }
                    
                    HStack(spacing: 5) {
                        Image(systemName: "viewfinder.circle.fill")
                            .font(.body)
                            .foregroundColor(.primary)
                        
                        Text("Area: ")
                            .foregroundColor(.primary)
                        + Text(acres)
                            .foregroundColor(.secondary.opacity(0.7))
                    }
                    
                    HStack(spacing: 5) {
                        Image(systemName: "lock.circle.fill")
                            .font(.body)
                            .foregroundColor(.primary)
                        
                        Text("Containment: ")
                            .foregroundColor(.primary)
                        + Text(containment)
                            .foregroundColor(.secondary.opacity(0.7))
                    }
                }
                .font(.callout)
                .padding(.top, 16)
                .padding([.horizontal, .bottom], 20)
            }
        }
    }
}
