//
//  FiresViewiPad.swift
//  Blaze-iPad
//
//  Created by Paul Wong on 10/26/20.
//
import SwiftUI

struct FiresViewiPad: View {
    @EnvironmentObject var fireB: FireBackend
    @State var selectAll = 0
    @State var selectLargest = 0
    
    @State var progress = 0.0
    @State var show = false
    @State var done = false
    @State var showingData = false
    @State var showingFullMap = false
    @State var showingMonitor = false

    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    Image("hydrant").resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 300)
                        .padding(.vertical, 100)
                    
                        Header(title: "Wildfires", desc: "Uncontrollable fires that spreads quickly over vegetation in rural areas. The scale of destruction is largely driven by weather conditions.")
                        
                    HStack(spacing: 15) {
                        Button(action: {
                            self.showingFullMap.toggle()
                        }) {
                            TabLongButton(symbol: "map", text: "Fire Map", background: Color(.tertiarySystemBackground))
                        }
                        .sheet(isPresented: $showingFullMap) {
                            FullFireMapModalViewiPad()
                        }
                        
                        Button(action: {
                            self.showingData.toggle()
                        }) {
                            TabLongButton(symbol: "tray.2", text: "Data", background: Color(.tertiarySystemBackground))

                        }
                        .sheet(isPresented: $showingData) {
                            DataViewiPad(showModal: self.$showingData)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, -5)
                    
                    Button(action: {
                        self.showingMonitor.toggle()
                    }) {
                        TabLongButton(symbol: "doc.text.magnifyingglass", text: "Monitoring List", background: Color(.tertiarySystemBackground))
                    }
                    .sheet(isPresented: $showingMonitor) {
                        MonitoringListViewiPad().environmentObject(fireB)
                    }
                    .padding([.horizontal, .bottom], 20)
                }
            }
            .background(Color(.secondarySystemBackground))
            .navigationBarTitle("", displayMode: .inline)
            
            ScrollView {
                SubHeader(title: "Largest Fires", description: "Wildfires will be sorted according to their sizes from largest to smallest.")
                    .padding(.top, 20)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        LazyVGrid(
                            columns: Array(repeating: GridItem(.fixed(220), spacing: 20), count: 5),
                            spacing: 20
                        ) {
                            ForEach(
                                fireB.fires.sorted(by: { $0.acres > $1.acres }).prefix(10).indices,
                                id: \.self
                            ) { index in
                                NavigationLink(
                                    destination: FireMapViewiPad(
                                        fireData: fireB.fires.sorted(by: { $0.acres > $1.acres })[index]
                                    )
                                ) {
                                    MiniFireCardiPad(
                                        selected: index == selectLargest,
                                        fireData: fireB.fires.sorted(by: { $0.acres > $1.acres })[index],
                                        area: true
                                    )
                                }
                            }
                        }
                        Spacer()
                        
                        NavigationLink(destination: FullFireMapViewiPad()) {
                            MoreButton(symbol: "plus.circle", text: "View All")
                        }
                        .padding(.leading, -20)
                    }
                    .padding(20)
                }
                
                Divider().padding(20)
                
                SubHeader(title: "Latest Fires", description: "Recently updated fires will be shown first.")
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        LazyVGrid(
                            columns: Array(repeating: GridItem(.fixed(220), spacing: 20), count: 5),
                            spacing: 20
                        ) {
                            ForEach(fireB.fires.sorted(by: { $0.updated > $1.updated }).prefix(10).indices, id: \.self) { index in
                                NavigationLink(
                                    destination: FireMapViewiPad(
                                        fireData: fireB.fires.sorted(by: { $0.updated > $1.updated })[index]
                                    )
                                ) {
                                    MiniFireCardiPad(
                                        selected: index == selectAll,
                                        fireData: fireB.fires.sorted(by: { $0.updated > $1.updated })[index],
                                        area: false
                                    )
                                }
                            }
                        }
                        Spacer()
                        NavigationLink(destination: FullFireMapViewiPad()) {
                            MoreButton(symbol: "plus.circle", text: "View All")
                        }
                        .padding(.leading, -20)
                    }
                    .padding(20)
                }
                Caption("Updates to fire data cannot be guaranteed on a set time schedule. Please use the information in Blaze only as a reference. This app is not meant to provide real-time evacuation or fire behavior information.")
            }
            .navigationBarTitle("Wildfires", displayMode: .inline)
        }
        .ignoresSafeArea(.all)
    }
}
