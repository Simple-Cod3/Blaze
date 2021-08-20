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
    
    var body: some View {
        if done {
            NavigationView {
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
                                .padding(.horizontal, 20)
                            }
                            .edgesIgnoringSafeArea(.horizontal)

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
}
