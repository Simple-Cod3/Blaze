//
//  FiresView.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import SwiftUI

struct FiresView: View {
    
    @EnvironmentObject var fireB: FireBackend

    @State private var prefix = 5
    @State private var largest = true
    @State private var latest = false
    @State private var monitorList = false

    @Binding var showFireInformation: String
    @Binding var popup: Bool
    @Binding var secondaryPopup: Bool
    @Binding var secondaryClose: Bool
    
    init(showFireInformation: Binding<String>, popup: Binding<Bool>, secondaryPopup: Binding<Bool>, secondaryClose: Binding<Bool>) {
        self._showFireInformation = showFireInformation
        self._popup = popup
        self._secondaryPopup = secondaryPopup
        self._secondaryClose = secondaryClose
    }
    
    func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
        return UIFont.preferredFont(forTextStyle: textStyle).pointSize
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderButton("Wildfires Overview")
                .padding(.bottom, popup ? 0 : UIConstants.bottomPadding+UIScreen.main.bounds.maxY*0.85)

            if popup {
                wildfiremain
            }
        }
    }
    
    private var wildfiremain: some View {
        VStack(spacing: 0) {
            Divider()
                .padding(.horizontal, UIConstants.margin)

            ScrollView {
                VStack(spacing: 0) {
                    Button(action: {
                        largest = false
                        latest = false
                        monitorList = true
                    }) {
                        RectButton(selected: $monitorList, "Monitoring List")
                    }
                    .buttonStyle(DefaultButtonStyle())
                    
                    HStack(spacing: 10) {
                        Button(action: {
                            largest = true
                            latest = false
                            monitorList = false
                        }) {
                            RectButton(selected: $largest, "Largest Fires")
                        }
                        .buttonStyle(DefaultButtonStyle())
                        
                        Button(action: {
                            largest = false
                            latest = true
                            monitorList = false
                        }) {
                            RectButton(selected: $latest, "Latest Fires")
                        }
                        .buttonStyle(DefaultButtonStyle())
                    }
                    .padding(.top, 11)
                    
                    Group {
                        if monitorList {
                            SubHeader(
                                title: "Monitoring List",
                                desc: "Showing pinned wildfires."
                            )
                            .transition(.opacity)
                        } else if largest {
                            SubHeader(
                                title: "Largest Fires",
                                desc: "Wildfires are sorted according to their sizes from largest to smallest."
                            )
                            .transition(.opacity)
                        } else if latest {
                            SubHeader(
                                title: "Latest Fires",
                                desc: "Wildfires are sorted based on time updated."
                            )
                            .transition(.opacity)
                        }
                    }
                    .padding(.vertical, UIConstants.margin)

                    VStack(spacing: 13) {
                        if largest {
                            ForEach(
                                fireB.fires.sorted(by: { $0.acres > $1.acres }).prefix(prefix).indices,
                                id: \.self
                            ) { index in
                                    FireCard(
                                        showFireInformation: $showFireInformation,
                                        popup: $popup,
                                        secondaryPopup: $secondaryPopup,
                                        secondaryClose: $secondaryClose,
                                        fireData: fireB.fires.sorted(by: { $0.acres > $1.acres })[index],
                                        area: true
                                    )
                            }
                        } else if latest {
                            ForEach(
                                fireB.fires.sorted(by: { $0.updated > $1.updated }).prefix(prefix).indices,
                                id: \.self
                            ) { index in
                                    FireCard(
                                        showFireInformation: $showFireInformation,
                                        popup: $popup,
                                        secondaryPopup: $secondaryPopup,
                                        secondaryClose: $secondaryClose,
                                        fireData: fireB.fires.sorted(by: {
                                            $0.updated > $1.updated
                                        })[index],
                                        area: false
                                    )
                            }
                        }
                    
                        if monitorList {
                            ForEach(fireB.monitoringFires) { fire in
                                MonitorFireCard(
                                    showFireInformation: $showFireInformation,
                                    popup: $popup,
                                    secondaryPopup: $secondaryPopup,
                                    secondaryClose: $secondaryClose,
                                    fireData: fire
                                )
                                .buttonStyle(PlainButtonStyle())
                                .contextMenu {
                                    Button(action: { fireB.removeMonitoredFire(name: fire.name) }) {
                                        Label("Remove Pin", systemImage: "pin.slash")
                                    }
                                }
                            }
                        }
                        
                        if !monitorList && prefix < fireB.fires.count {
                            Button(action: {
                                prefix += 5
                            }) {
                                MoreButton(symbol: "plus.circle", text: "View More", color: .blaze)
                            }
                            .buttonStyle(DefaultButtonStyle())
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
