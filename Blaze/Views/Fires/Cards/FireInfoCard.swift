//
//  POCFireInfoCard.swift
//  Blaze
//
//  Created by Polarizz on 10/21/21.
//

import SwiftUI

struct FireInfoCard: View {
    
    @Environment(\.colorScheme) var colorScheme

    @State private var random = false
    @State private var data = true
    @State private var info = false
    
    @Binding var secondaryPopup: Bool
    @Binding var secondaryClose: Bool

    var fireData: ForestFire
    
    init(secondaryPopup: Binding<Bool>, secondaryClose: Binding<Bool>, fireData: ForestFire) {
        self._secondaryPopup = secondaryPopup
        self._secondaryClose = secondaryClose
        self.fireData = fireData
    }
    
    func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
        return UIFont.preferredFont(forTextStyle: textStyle).pointSize
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Button(action: {
                    UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                    withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) { secondaryPopup.toggle() }
                }) {
                    SecondaryHeaderButton(secondaryClose: $secondaryClose, fireData.name)
                        .padding(.bottom, secondaryPopup ? 0 : UIConstants.bottomPadding+UIScreen.main.bounds.maxY*0.85)
                }
                .buttonStyle(DefaultButtonStyle())
            }

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
