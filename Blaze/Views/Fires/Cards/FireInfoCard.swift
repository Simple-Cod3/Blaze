//
//  POCFireInfoCard.swift
//  Blaze
//
//  Created by Polarizz on 10/21/21.
//

import SwiftUI

struct FireInfoCard: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var mapController: FullFireMapController

    @State private var random = false
    @State private var data = true
    @State private var info = false
    
    @Binding var secondaryPopup: Bool
    @Binding var secondaryShow: Bool
    @Binding var popup: Bool
    @Binding var showLabels: Bool

    var staticModal: Bool
    var fireData: ForestFire
    
    init(secondaryPopup: Binding<Bool>?=nil, secondaryShow: Binding<Bool>?=nil, popup: Binding<Bool>?=nil, showLabels: Binding<Bool>?=nil, fireData: ForestFire, staticModal: Bool?=nil) {
        self._secondaryPopup = secondaryPopup ?? .constant(true)
        self._secondaryShow = secondaryShow ?? .constant(false)
        self._popup = popup ?? .constant(true)
        self._showLabels = showLabels ?? .constant(true)
        self.fireData = fireData
        self.staticModal = staticModal ?? false
    }
    
    func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
        return UIFont.preferredFont(forTextStyle: textStyle).pointSize
    }
    
    var body: some View {
        VStack(spacing: 0) {
            SecondaryHeaderButton(
                popup: $popup,
                secondaryPopup: $secondaryPopup,
                secondaryShow: $secondaryShow,
                showLabels: $showLabels,
                fireData.name,
                staticModal: staticModal
            )
                .padding(.bottom, secondaryPopup ? 0 : UIConstants.bottomPadding+UIScreen.main.bounds.maxY*0.85)

            if secondaryPopup {
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
                    VStack(spacing: 10) {
                        if !staticModal {
                            Button(action: {
                                withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) {
                                    showLabels = true
                                    secondaryShow = true
                                    secondaryPopup = false
                                    mapController.moveBack(lat: fireData.latitude, long: fireData.longitude, span: 0.3)
                                }

                                mapController.moveBack(lat: fireData.latitude, long: fireData.longitude, span: 1)
                            }) {
                                RectButton(selected: .constant(false), "Show in Map")
                            }
                            .buttonStyle(DefaultButtonStyle())
                        }

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
                    }

                    InformationView(data: $data, info: $info, fireData: fireData)
                }
                .padding(UIConstants.margin)
                .padding(.bottom, UIConstants.bottomPadding*2)
                .padding(.bottom, (textSize(textStyle: .largeTitle)*4))
            }
        }
    }
}
