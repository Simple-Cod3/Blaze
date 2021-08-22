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
    @State private var data = true
    @State private var info = false
    
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
                    .contentShape(Rectangle())
                }
                .buttonStyle(DefaultButtonStyle())
                
                Spacer()

                if popup {
                    Button(action: {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) { showFireInformation = false }
                    }) {
                        SymbolButton("chevron.left", Color(.tertiaryLabel))
                            .padding(.leading, 10)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(DefaultButtonStyle())
                }
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
                    Button(action: {
                        withAnimation(.spring(response: 0.3)) {
                            data = true
                            info = false
                        }
                    }) {
                        RectButton(selected: $data, "Data")
                    }
                    .buttonStyle(DefaultButtonStyle())
                    
                    Button(action: {
                        withAnimation(.spring(response: 0.3)) {
                            data = false
                            info = true
                        }
                    }) {
                        RectButton(selected: $info, "Information")
                    }
                    .buttonStyle(DefaultButtonStyle())
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)

                if data {
                    InformationView(data: $data, info: $info, fireData: fireData)
                        .padding(.top, 16)
                        .padding([.horizontal, .bottom], 20)
                }
            }
        }
    }
}
