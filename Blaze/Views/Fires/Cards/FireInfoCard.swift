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
    private var soloNavigation: Bool
    
    init(popup: Binding<Bool>, showFireInformation: Binding<String>?=nil, fireData: ForestFire, soloNavigation: Bool?=nil) {
        self._popup = popup
        self._showFireInformation = showFireInformation ?? .constant(fireData.name)
        self.fireData = fireData
        self.name = fireData.name
        self.locations = fireData.getLocation()
        self.acres = fireData.getAreaString()
        self.containment = "\(fireData.getContained()) Contained"
        self.updated = "\(fireData.updated.getDateTime())"
        self.started = "\(fireData.started.getDateTime())"
        self.soloNavigation = soloNavigation ?? false
    }
    
    func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
        return UIFont.preferredFont(forTextStyle: textStyle).pointSize
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Button(action: {
                    UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                    withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) { popup.toggle() }
                }) {
                    FireHeaderButton(name)
                        .padding(.bottom, popup ? 0 : UIConstants.bottomPadding+UIScreen.main.bounds.maxY*0.85)
                }
                .buttonStyle(DefaultButtonStyle())
                
                Spacer()

                if popup && !soloNavigation {
                    Button(action: {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) { showFireInformation = "" }
                    }) {
                        TrailingButton("chevron.left")
                    }
                    .buttonStyle(NoButtonStyle())
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
                .padding(.horizontal, UIConstants.margin)
            
            ScrollView {
                VStack(spacing: 0) {
                    HStack(spacing: 10) {
                        Button(action: {
                            withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) {
                                data = true
                                info = false
                            }
                        }) {
                            RectButton(selected: $data, "Data")
                        }
                        .buttonStyle(DefaultButtonStyle())
                        
                        Button(action: {
                            withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) {
                                data = false
                                info = true
                            }
                        }) {
                            RectButton(selected: $info, "Information")
                        }
                        .buttonStyle(DefaultButtonStyle())
                    }
                    .padding(.bottom, UIConstants.margin)

                    InformationView(data: $data, info: $info, fireData: fireData)
                }
                .padding(UIConstants.margin)
                .padding(.bottom, UIConstants.bottomPadding)
                .padding(.bottom, (textSize(textStyle: .largeTitle)*4))
            }
        }
    }
}
