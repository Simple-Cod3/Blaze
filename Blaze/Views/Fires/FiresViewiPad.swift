//
//  FiresView.swift
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
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                Image("hydrant").resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 300)
                    .padding(.vertical, 100)
                
                VStack(spacing: 20) {
                    HStack {
                        Header(title: "Wildfires", desc: "Uncontrollable fires that spreads quickly over vegetation in rural areas. The scale of destruction is largely driven by weather conditions.")
                        Spacer()
                    }
                    
                    HStack(spacing: 20) {
                        Button(action: {
                            self.showingFullMap.toggle()
                        }) {
                            HStack {
                                Spacer()
                                Text("\(Image(systemName: "map")) Fire Map")
                                    .fontWeight(.regular)
                                    .font(.body)
                                    .foregroundColor(.blaze)
                                Spacer()
                            }
                            .padding(.vertical, 12)
                            .padding(.horizontal, 10)
                            .background(Color(.tertiarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        }
                        .sheet(isPresented: $showingFullMap) {
                            FullFireMapModalView()
                        }
                        
                        Button(action: {
                            self.showingData.toggle()
                        }) {
                            HStack {
                                Spacer()
                                Text("\(Image(systemName: "tray.2")) Data")
                                    .fontWeight(.regular)
                                    .font(.body)
                                    .foregroundColor(.blaze)
                                Spacer()
                            }
                            .padding(.vertical, 12)
                            .padding(.horizontal, 10)
                            .background(Color(.tertiarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        }
                        .sheet(isPresented: $showingData) {
                            DataView()
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 20)
            }
            .background(Color(.secondarySystemBackground))
            .navigationBarTitle("", displayMode: .inline)
            
            ScrollView {
                SubHeader(title: "Largest Fires", description: "Wildfires will be sorted according to their sizes from largest to smallest.")
                    .padding(.top, 40)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        LazyVGrid(columns: [
                            GridItem(.fixed(220), spacing: 20), GridItem(.fixed(220), spacing: 20), GridItem(.fixed(220), spacing: 20), GridItem(.fixed(220), spacing: 20), GridItem(.fixed(220), spacing: 20)
                        ], spacing: 20) {
                            ForEach(
                                fireB.fires.sorted(by: { $0.acres > $1.acres }).prefix(10).indices,
                                id: \.self
                            ) { index in
                                NavigationLink(destination: FireMapView(fireData: fireB.fires.sorted(by: { $0.acres > $1.acres })[index])) {
                                    MiniFireCard(
                                        selected: index == selectLargest,
                                        fireData: fireB.fires.sorted(by: { $0.acres > $1.acres })[index],
                                        area: true
                                    )
                                }
                            }
                        }
                        Spacer()
                        
                        NavigationLink(destination: FullFireMapView()) {
                            HStack {
                                Image(systemName: "plus.circle")
                                Text("View All")
                            }
                        }
                    }
                    .padding(20)
                }
                
                Divider().padding(20)
                
                SubHeader(title: "Latest Fires", description: "Recently updated fires will be shown first.")
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        LazyVGrid(columns: [
                            GridItem(.fixed(220), spacing: 20), GridItem(.fixed(220), spacing: 20), GridItem(.fixed(220), spacing: 20), GridItem(.fixed(220), spacing: 20), GridItem(.fixed(220), spacing: 20)
                        ], spacing: 20) {
                            ForEach(fireB.fires.sorted(by: { $0.updated > $1.updated }).prefix(10).indices, id: \.self) { index in
                                NavigationLink(destination: FireMapView(fireData: fireB.fires.sorted(by: { $0.updated > $1.updated })[index])) {
                                    MiniFireCard(selected: index == selectAll, fireData: fireB.fires.sorted(by: { $0.updated > $1.updated })[index], area: false)
                                }
                            }
                        }
                        Spacer()
                        NavigationLink(destination: FullFireMapView()) {
                            HStack {
                                Image(systemName: "plus.circle")
                                Text("View All")
                            }
                        }
                    }
                    .padding(20)
                }
            }
            .navigationBarTitle("Wildfires", displayMode: .inline)
        }
        .ignoresSafeArea(.all)
    }
}
