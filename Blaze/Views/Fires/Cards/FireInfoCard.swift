//
//  FireInfoCard.swift
//  Blaze
//
//  Created by Paul Wong on 9/4/20.
//

import SwiftUI

struct FireInfoCard: View {
    
    @Environment(\.colorScheme) var colorScheme

    @State private var random = false
    @State private var data = true
    @State private var info = false
    
    @Binding var popup: Bool
    @Binding var showFireInformation: String
    
    private var fireData: ForestFire
    private var name: String
    private var locations: String
    private var acres: String
    private var containment: String
    private var updated: String
    private var started: String
    
    init(popup: Binding<Bool>, showFireInformation: Binding<String>, fireData: ForestFire) {
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
                        Image(systemName: "flame.fill")
                            .font(.footnote)
                            .foregroundColor(.blaze)
                            .padding(7)
                            .background(colorScheme == .dark ? Color(.tertiarySystemBackground) : Color.borderBackground)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(colorScheme == .dark ? (Color.borderBackground) : Color(.tertiarySystemBackground), lineWidth: 2)
                            )
                            .padding(.trailing, 10)
                        
                        Text(name)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        SymbolButton(popup ? "chevron.down" : "chevron.up")
                    }
                    .padding([.leading, .vertical], 20)
                    .padding(.trailing, popup ? 0 : 20)
                    .contentShape(Rectangle())
                }
                .buttonStyle(DefaultButtonStyle())
                
                Spacer()

                if popup {
                    Button(action: {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) { showFireInformation = "" }
                    }) {
                        TrailingButton("chevron.left")
                    }
                    .buttonStyle(DefaultButtonStyle())
                }
            }
            
            if popup {
                fireinformation
            }
        }
    }
    
    private var fireinformation: some View {
        VStack(spacing: 0) {
            Divider()
                .padding(.horizontal, 20)

            VStack(spacing: 0) {
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

                InformationView(data: $data, info: $info, fireData: fireData)
                    .padding(.top, 16)
                    .padding(.bottom, 20)
            }
        }
    }
}
