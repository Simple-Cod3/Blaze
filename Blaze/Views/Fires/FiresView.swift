//
//  FiresView.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import SwiftUI

struct FiresView: View {
    
    @EnvironmentObject var fireB: FireBackend
    @State var selectAll = 0
    @State var selectLargest = 0
    
    @State var progress = 0.0
    @State var data = false
    @State var show = false
    @State var done = false
    @State var popup = false
    @State var aqi = false
    
    var body: some View {
        if done {
            VStack {
                FullFireMapView()
                
//                ZStack(alignment: .top) {
//                        Image("hydrant").resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(height: 275)
//                            .padding(60)
//
//                        VStack(spacing: 20) {
//                            Header(title: "Wildfires", desc: "Uncontrollable fires that spreads quickly over vegetation in rural areas. The scale of destruction is largely driven by weather conditions.")
//
//                            NavigationLink(destination: FullFireMapView()) {
//                                VerticalButton(symbol: "map", text: "Fire Map", desc: "See wildfires on a greater scale", mark: "chevron.forward")
//                            }
//                            .buttonStyle(CardButtonStyle())
//
//                            NavigationLink(destination: MonitoringListView()) {
//                                VerticalButton(symbol: "doc.text.magnifyingglass", text: "Monitoring List", desc: "\(fireB.monitoringFires.count) fires pinned", mark: "chevron.forward")
//                            }
//                            .buttonStyle(CardButtonStyle())
//                            .padding(.top, -5)
//                            .padding(.bottom, 10)
//
//                            SubHeader(title: "Largest Fires", description: "Wildfires will be sorted according to their sizes from largest to smallest.")
                            

//                            Divider().padding(.horizontal, 20).padding(.vertical, 10)
//
//                            SubHeader(title: "Latest Fires", description: "Recently updated fires will be shown first.")
//
//                            ScrollView(.horizontal, showsIndicators: false) {
//                                HStack(spacing: 20) {
//                                    ForEach(
//                                        fireB.fires.sorted(by: { $0.updated > $1.updated }).prefix(5).indices,
//                                        id: \.self
//                                    ) { index in
//                                        NavigationLink(
//                                            destination: FireMapView(
//                                                fireData: fireB.fires.sorted(by: { $0.updated > $1.updated })[index]
//                                            )
//                                        ) {
//                                            MiniFireCard(selected: index == selectAll, fireData: fireB.fires.sorted(by: { $0.updated > $1.updated })[index], area: false)
//                                        }
//                                        .buttonStyle(NoButtonStyle())
//                                    }
//                                    Spacer()
//                                    NavigationLink(destination: FullFireMapView()) {
//                                        MoreButton(symbol: "plus.circle", text: "View All")
//                                    }.buttonStyle(CardButtonStyle())
//                                    .padding(.leading, -20)
//                                }
//                                .padding(.horizontal, 20)
//                            }
//                            .edgesIgnoringSafeArea(.horizontal)
//
//                            Caption("Updates to fire data cannot be guaranteed on a set time schedule. Please use the information in Blaze only as a reference. This app is not meant to provide real-time evacuation or fire behavior information.")
//                        }
//                        .navigationBarTitle("Wildfires", displayMode: .inline)
//                        .navigationBarHidden(true)
            }
            .opacity(show ? 1 : 0)
            .onAppear {
                self.show = true
            }
            .overlay(
//                VStack(spacing: 0) {
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack(spacing: 20) {
//                            ForEach(
//                                fireB.fires.sorted(by: { $0.acres > $1.acres }).prefix(5).indices,
//                                id: \.self
//                            ) { index in
//                                NavigationLink(
//                                    destination: FireMapView(
//                                        fireData: fireB.fires.sorted(by: { $0.acres > $1.acres })[index]
//                                    )
//                                ) {
//                                    MiniFireCard(
//                                        selected: index == selectLargest,
//                                        fireData: fireB.fires.sorted(by: { $0.acres > $1.acres })[index],
//                                        area: true
//                                    )
//                                }
//                                .buttonStyle(NoButtonStyle())
//                            }
//                            Spacer()
//                            NavigationLink(destination: FullFireMapView()) {
//                                MoreButton(symbol: "plus.circle", text: "View All")
//                            }.buttonStyle(CardButtonStyle())
//                            .padding(.leading, -20)
//                        }
//                        .padding(20)
//                    }
//                },
                main,
                alignment: .bottom
            )
            .overlay(
                Button(action: {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) { aqi.toggle() }
                }) {
                    VStack(alignment: .leading, spacing: 5) {
                        HStack(spacing: 5) {
                            Image(systemName: aqi ? "aqi.high" : "flame")
                                .font(.body.bold())
                                .foregroundColor(.white)
                            
                            Text(aqi ? "Air Quality" : "Wildfires")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            
                            Spacer()
                        
                            Text(aqi ? "See Wildfires" : "See AQI")
                                .font(.footnote)
                                .fontWeight(.medium)
                                .foregroundColor(.white.opacity(0.7))

                            Image(systemName: aqi ? "flame" : "aqi.high")
                                .font(.caption.bold())
                                .foregroundColor(.white)
                        }
                        
                        Text(aqi ? "Displaying air quality in San Francisco." : "Showing 390 hotspots across the United States.")
                            .font(.callout)
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .padding(20)
                    .background(aqi ? Color.yellow : Color.blaze)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .padding(20)
                }
                .buttonStyle(ShrinkButtonStyle()),
                alignment: .top
            )
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        } else if fireB.failed {
            VStack(spacing: 20) {
                Image(systemName: "wifi.exclamationmark")
                    .font(.system(size: 30))
                    .foregroundColor(.blaze)
                
                Text("No Connection")
                    .font(.title)
                    .fontWeight(.bold)
                
                Button("Click to Retry", action: { fireB.refreshFireList() })
            }
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
                Hero(
                    "flame",
                    "Wildfires",
                    "Uncontrollable fires that spreads quickly over vegetation in rural areas. The scale of destruction is largely driven by weather conditions.",
                    Color.blaze
                )
                .opacity(0)
            }
            
            VStack(spacing: 0) {
                Button(action: {
                    UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) { popup.toggle() }
                }) {
                    HStack(spacing: 0) {
                        Text(aqi ? "Air Quality Data" : "Wildfire Overview")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Image(systemName: popup ? "chevron.down" : "chevron.up")
                            .font(.callout.bold())
                            .foregroundColor(Color(.tertiaryLabel))
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .contentShape(Rectangle())
                }
                .buttonStyle(DefaultButtonStyle())
                
                if popup {
                    VStack {
                        Divider()
                            .padding(.top, 20)
                            .padding(.horizontal, 20)

                        ScrollView(showsIndicators: false) {
                            SubHeader(title: "Largest Fires", description: "Wildfires are sorted according to their sizes from largest to smallest.")
                                .padding(.top, 20)
                                .padding(.horizontal, 20)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 20) {
                                    ForEach(
                                        fireB.fires.sorted(by: { $0.acres > $1.acres }).prefix(5).indices,
                                        id: \.self
                                    ) { index in
                                        NavigationLink(
                                            destination: FireMapView(
                                                fireData: fireB.fires.sorted(by: { $0.acres > $1.acres })[index]
                                            )
                                        ) {
                                            MiniFireCard(
                                                selected: index == selectLargest,
                                                fireData: fireB.fires.sorted(by: { $0.acres > $1.acres })[index],
                                                area: true
                                            )
                                        }
                                        .buttonStyle(NoButtonStyle())
                                    }
                                    Spacer()
                                    NavigationLink(destination: FullFireMapView()) {
                                        MoreButton(symbol: "plus.circle", text: "View All")
                                    }.buttonStyle(CardButtonStyle())
                                    .padding(.leading, -20)
                                }
                                .padding(20)
                            }
                        }
                        
                        Spacer()
                    }
                }
            }
            .padding(.bottom, 20)
            .background(ProminentBlurBackground())
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .padding([.horizontal, .bottom], 20)
        }
    }
}
