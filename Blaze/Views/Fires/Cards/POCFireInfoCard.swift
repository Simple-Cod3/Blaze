//
//  POCFireInfoCard.swift
//  Blaze
//
//  Created by Polarizz on 10/21/21.
//

import SwiftUI

struct POCFireInfoCard: View {
    
    @Environment(\.colorScheme) var colorScheme

    @State private var random = false
    @State private var data = true
    @State private var info = false
    
    @Binding var secondaryPopup: Bool
    @Binding var secondaryClose: Bool
    
    init(secondaryPopup: Binding<Bool>, secondaryClose: Binding<Bool>) {
        self._secondaryPopup = secondaryPopup
        self._secondaryClose = secondaryClose
    }
    
    func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
        return UIFont.preferredFont(forTextStyle: textStyle).pointSize
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                FireHeaderButton(secondaryClose: $secondaryClose, "Name")
                    .padding(.bottom, secondaryPopup ? 0 : UIConstants.bottomPadding+UIScreen.main.bounds.maxY*0.85)
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
                        RectButton(selected: $data, "Data")
                        
                        RectButton(selected: $info, "Information")
                    }
                    .padding(.bottom, UIConstants.margin)

                    VStack(spacing: 13) {
                        DataCard(
                            "flame",
                            "Incident",
                            "fireData.name",
                            .blaze
                        )
                        
                        DataCard(
                            "location",
                            "Location",
                            "fireData.getLocation()",
                            .blaze
                        )

                        DataCard(
                            "clock.arrow.2.circlepath",
                            "Last Updated",
                            "fireData.updated.getElapsedInterval(true)",
                            .blaze
                        )
                        
                        DataCard(
                            "calendar.badge.clock",
                            "Fire Started",
                            "fireData.started.getElapsedInterval(true)",
                            .blaze
                        )

                        DataCard(
                            "location.viewfinder",
                            "Area Burned",
                            "fireData.getAreaString()",
                            .blaze
                        )
                        
                        DataCard(
                            "checkmark.shield",
                            "Area Contained",
                            "fireData.getContained()",
                            .blaze
                        )

                        HStack(spacing: 0) {
                            Spacer()
                            
                            MoreButtonLink(url: URL(string: "https://google.com")!)
                                .disabled(true)
                            
                            Spacer()
                        }
                    }
                }
                .padding(UIConstants.margin)
                .padding(.bottom, UIConstants.bottomPadding)
                .padding(.bottom, (textSize(textStyle: .largeTitle)*4))
            }
        }
    }
}
