//
//  FiresView.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import SwiftUI
import Containers

struct FiresView: View {
    
    @EnvironmentObject var fireB: FireBackend
    @EnvironmentObject var forecast: AirQualityBackend
    
    @State var selectAll = 0
    @State var selectLargest = 0
    
    @State var progress = 0.0
    @State var data = false
    @State var done = false
    @State private var popup = false
    @State var wildfire = true
    @State var showFireInformation = false
    @State var aqi = false
    @State var news = false
    @State var prefix = 10
    @State var showLabels = false
    @State var largest = true
    @State var latest = false
    @State private var zoom = false
    @State var monitorList = false
    @State var showSettings = false
    @State var page = 0
    @State var shrink = false
    
    var body: some View {
        if done {
            VStack(spacing: 0) {
                Button(action: {
                    withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) {
                        popup = false
                    }
                }) {
                    FullFireMapView(showLabels: $showLabels)
                }
                .buttonStyle(NoButtonStyle())
            }
            .overlay(
                PagerView(pageCount: 3, currentIndex: $page) {
                    ForEach(0..<3) { page in
                        HeroCard(page)
                    }
                }
                ,
                alignment: .top
            )
            .overlay(
                main,
                alignment: .bottom
            )
        } else if fireB.failed {
        
        } else {
            ProgressBarView(
                progressObjs: $fireB.progress,
                progress: $progress,
                done: $done
            )
        }
    }
    
    private var main: some View {

        VStack(spacing: 0) {
            Hero(
                "flame",
                "Wildfires",
                "Showing 390 hotspots across the United States.",
                Color.blaze
            )
            .opacity(0)
                
            VStack(alignment: .leading, spacing: 0) {
                if !popup && !showSettings {
                    Option(page == 0 ? Color.blaze : page == 1 ? determineColor(cat: forecast.forecasts[1].category.number) : Color.orange)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 15)
                }
                
                if !zoom {
                    VStack(spacing: 0) {
                        if page == 0 {
                            if !showFireInformation {
                                Button(action: {
                                    UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                                    withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) {
                                        popup.toggle()
                                    }
                                }) {
                                    HeaderButton("Wildfires Overview", popup ? "chevron.down" : "chevron.up")
                                }
                                .buttonStyle(DefaultButtonStyle())
                                .padding(.trailing, 20)
                                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                                    .onEnded({ value in
                                        if value.translation.height > 0 {
                                            withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) {
                                                popup = false
                                            }
                                        } else {
                                            withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) {
                                                popup = true
                                            }
                                        }
                                    }))

                                if popup {
                                    wildfiremain
                                }
                            } else {
                                FireInfoCard(popup: $popup, showFireInformation: $showFireInformation, wildfire: $wildfire, aqi: $aqi, news: $news, fireData: fireB.fires.sorted(by: { $0.acres > $1.acres })[3])
                            }
                        }
                        
                        if page == 1 {
                            AQView(popup: $popup)
                        }
                        
                        if page == 2 {
                            NewsView(popup: $popup)
                        }
                    }
                    .background(RegularBlurBackground())
                    .padding(.bottom, shrink ? -20 : 0)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .padding([.horizontal, .bottom], 20)
                    .padding(.top, showSettings ? 20 : 0)
                }
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
                    .padding(.horizontal, 20)
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
                    .padding(.horizontal, 20)
                    .padding(.top, 11)
                    
                    SubHeader(
                        title: monitorList ? "Monitoring List" : (largest ? "Largest Fires" : "Latest Fires"),
                        desc: monitorList ? "Showing pinned wildfires." : (largest ? "Wildfires are sorted according to their sizes from largest to smallest." : "Wildfires are sorted based on time updated.")
                    )
                    .padding(.top, 20)
                    .padding(.horizontal, 20)

                    VStack(spacing: 13) {
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
                    .padding(.horizontal, 20)
                }
            }
        }
    }
}
