//
//  FiresView.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import SwiftUI

struct FiresView: View {
    
    @EnvironmentObject var fireB: FireBackend

    @State private var showFireInformation = ""
    @State private var prefix = 10
    @State private var largest = true
    @State private var latest = false
    @State private var monitorList = false
    
    @Binding var popup: Bool
    
    init(popup: Binding<Bool>) {
        self._popup = popup
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if showFireInformation == "" {
                Button(action: {
                    UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                    withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) {
                        popup.toggle()
                    }
                }) {
                    HeaderButton("Wildfires Overview", popup ? "chevron.down" : "chevron.up")
                        .padding(.bottom, popup ? 0 : UIScreen.main.bounds.maxX)
                }
                .buttonStyle(DefaultButtonStyle())
                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onEnded({ value in
                        withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) {
                            popup = value.translation.height > 0 ? false : true
                        }
                    }))

                if popup {
                    wildfiremain
                }
            } else {
                FireInfoCard(popup: $popup, showFireInformation: $showFireInformation, fireData: fireB.fires.filter { $0.name == showFireInformation }[0])
            }
        }
    }
    
    private var wildfiremain: some View {
        VStack(spacing: 0) {
            Divider()
                .padding(.horizontal, 20)

            ScrollView {
                VStack(spacing: 0) {
                    Button(action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.9)) {
                            largest = false
                            latest = false
                            monitorList = true
                        }
                    }) {
                        RectButton(selected: $monitorList, "Monitoring List")
                    }
                    .buttonStyle(DefaultButtonStyle())
                    .padding(.top, 20)
                    
                    HStack(spacing: 10) {
                        Button(action: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.9)) {
                                largest = true
                                latest = false
                                monitorList = false
                            }
                        }) {
                            RectButton(selected: $largest, "Largest Fires")
                        }
                        .buttonStyle(DefaultButtonStyle())
                        
                        Button(action: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.9)) {
                                largest = false
                                latest = true
                                monitorList = false
                            }
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
                    .padding(.top, 20)

                    VStack(spacing: 13) {
                        if largest {
                            ForEach(
                                fireB.fires.sorted(by: { $0.acres > $1.acres }).prefix(prefix).indices,
                                id: \.self
                            ) { index in
                                FireCard(
                                    showFireInformation: $showFireInformation,
                                    popup: $popup,
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
                        
                        if !monitorList {
                            Button(action: {
                                prefix += 10
                            }) {
                                MoreButton(symbol: "plus.circle", text: "View More", color: .blaze)
                            }
                            .buttonStyle(DefaultButtonStyle())
                        }
                    }
                    .padding(.vertical, 16)
                }
                .padding(.horizontal, 20)
            }
        }
    }
}
