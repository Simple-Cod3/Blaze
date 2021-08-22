//
//  FiresView.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import SwiftUI
import MapKit

struct FiresView: View {
    
    @EnvironmentObject var fireB: FireBackend
    @EnvironmentObject var forecast: AirQualityBackend
    
    @State var selectAll = 0
    @State var selectLargest = 0
    
    @State var progress = 0.0
    @State var data = false
    @State var done = false
    @State private var popup = false
    @State var aqi = false
    @State var prefix = 10
    
    @State var showFireInformation = false
    
    var body: some View {
        if done {
            VStack {
                FullFireMapView()
                
//                            NavigationLink(destination: FullFireMapView()) {
//                                VerticalButton(symbol: "map", text: "Fire Map", desc: "See wildfires on a greater scale", mark: "chevron.forward")
//                            }
//                            .buttonStyle(CardButtonStyle())
//
//                            NavigationLink(destination: MonitoringListView()) {
//                                VerticalButton(symbol: "doc.text.magnifyingglass", text: "Monitoring List", desc: "\(fireB.monitoringFires.count) fires pinned", mark: "chevron.forward")
//                            }
//                            .buttonStyle(CardButtonStyle())
            }
            .overlay(
                main,
                alignment: .bottom
            )
            .overlay(
                Button(action: {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) {
                        aqi.toggle()
                        
                        if aqi {
                            popup = true
                        } else {
                            popup = false
                        }
                    }
                }) {
                    Hero(aqi: $aqi)
                        .padding(20)
                }
                .buttonStyle(ShrinkButtonStyle()),
                alignment: .top
            )
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
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
            if popup {
                Hero(aqi: $aqi)
                    .padding(20)
                    .opacity(0)
            }
                
            VStack(alignment: .leading, spacing: 0) {
                if !popup {
                    VStack(spacing: 15) {
                        Image(systemName: "bubble.middle.top")
                            .foregroundColor(aqi ? determineColor(cat: forecast.forecasts[1].category.number) : Color.blaze)
                        
                        Image(systemName: "location")
                            .foregroundColor(aqi ? determineColor(cat: forecast.forecasts[1].category.number) : Color.blaze)
                    }
                    .font(Font.title2.weight(.medium))
                    .padding(11)
                    .background(ProminentBlurBackground())
                    .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
                    .contentShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
                    .padding(.horizontal, 20)
                    .padding(.bottom, 13)
                }
                
                VStack(spacing: 0) {
                    if aqi {
                        AQView(popup: $popup)
                    } else if !showFireInformation {
                        Button(action: {
                            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                            withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) { popup.toggle() }
                        }) {
                            VStack(spacing: 0) {
                                HStack(spacing: 0) {
                                    Text("Wildfire Overview")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.primary)
                                    
                                    Spacer()
                                    
                                    Image(systemName: popup ? "chevron.down" : "chevron.up")
                                        .font(.callout.bold())
                                        .foregroundColor(Color(.tertiaryLabel))
                                }
                                .padding(20)
                            }
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(DefaultButtonStyle())
                        
                        if popup {
                            wildfiremain
                        }
                    } else {
                        FireInfoCard(popup: $popup, showFireInformation: $showFireInformation, fireData: fireB.fires.sorted(by: { $0.acres > $1.acres })[3])
                    }
                }
                .background(ProminentBlurBackground())
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .padding([.horizontal, .bottom], 20)
            }
        }
    }
    
    private var wildfiremain: some View {
        VStack(spacing: 0) {
            Divider()
                .padding(.horizontal, 20)

            ScrollView(showsIndicators: false) {
                HStack(spacing: 10) {
                    RectButton("Largest Fires")
                    RectButton("Latest Fires")
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                SubHeader(title: "Largest Fires", desc: "Wildfires are sorted according to their sizes from largest to smallest.")
                    .padding(.top, 16)
                    .padding(.horizontal, 20)

                VStack(spacing: 13) {
                    ForEach(
                        fireB.fires.sorted(by: { $0.acres > $1.acres }).prefix(prefix).indices,
                        id: \.self
                    ) { index in
                        FireCard(
                            showFireInformation: $showFireInformation,
                            selected: index == selectLargest,
                            fireData: fireB.fires.sorted(by: { $0.acres > $1.acres })[index],
                            area: true
                        )
                    }
                    
                    Button(action: {
                        prefix += 10
                        
                        print(prefix)
                    }) {
                        MoreButton(symbol: "plus.circle", text: "View More")
                    }
                    .buttonStyle(DefaultButtonStyle())
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 20)
                
//                VStack(spacing: 13) {
//                    ForEach(
//                        fireB.fires.sorted(by: { $0.updated > $1.updated }).prefix(prefix).indices,
//                        id: \.self
//                    ) { index in
//                        MiniFireCard(
//                            selected: index == selectAll,
//                            fireData: fireB.fires.sorted(by: {
//                                $0.updated > $1.updated
//                            })[index],
//                            area: false)
//                    }
//
//                    Button(action: {
//                        prefix += 10
//
//                        print(prefix)
//                    }) {
//                        MoreButton(symbol: "plus.circle", text: "View More")
//                    }
//                    .buttonStyle(DefaultButtonStyle())
//                }
//                .padding(.vertical, 16)
//                .padding(.horizontal, 20)
                
                Spacer()
            }
        }
    }
}
