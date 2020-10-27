//
//  FiresView.swift
//  Blaze-iPad
//
//  Created by Paul Wong on 10/26/20.
//

import SwiftUI

import SwiftUI

struct FiresView: View {
    @EnvironmentObject var fireB: FireBackend
    @State var selectAll = 0
    @State var selectLargest = 0
    
    @State var progress = 0.0
    @State var show = false
    @State var done = false
    
    var body: some View {
        HStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    Image("hydrant").resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 300)
                        .padding(.vertical, 75)
                    
                    NoticeCard(
                        title: "Deprecated Source",
                        text: "The current data source from fire.ca.gov has transfered monitoring ownership for multiple major fires. The development team is currently working on adding more data sources."
                    )
                    .padding(.bottom, 20)
                    
                    HStack {
                        Header(title: "Wildfires", desc: "Uncontrollable fires that spreads quickly over vegetation in rural areas. The scale of destruction is largely driven by weather conditions.")
                        Spacer()
                    }
                }
                
                HStack(spacing: 20) {
                    NavigationLink(destination: FullFireMapView()) {
                        HStack {
                            Spacer()
                            Text("\(Image(systemName: "map")) Fire Map")
                                .fontWeight(.regular)
                                .font(.body)
                                .foregroundColor(.blaze)
                            Spacer()
                        }
                    }
                    .padding(12)
                    .background(Color(.tertiarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    
                    NavigationLink(destination: DataView()) {
                        HStack {
                            Spacer()
                            Text("\(Image(systemName: "tray.2")) Data")
                                .fontWeight(.regular)
                                .font(.body)
                                .foregroundColor(.blaze)
                            Spacer()
                        }
                    }
                    .padding(12)
                    .background(Color(.tertiarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
                .padding(20)
                .padding(.bottom, 60)
            }
            .frame(width: UIScreen.main.bounds.width/3)
            .background(Color(.secondarySystemBackground))
            
            ScrollView {
                SubHeader(title: "Largest Fires", description: "Wildfires will be sorted according to their sizes from largest to smallest.")
                    .padding(.top, 40)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        LazyVGrid(columns: [
                            GridItem(.fixed(230), spacing: 20), GridItem(.fixed(230), spacing: 20), GridItem(.fixed(230), spacing: 20), GridItem(.fixed(230), spacing: 20)
                        ], spacing: 20) {
                            ForEach(
                                fireB.fires.sorted(by: { $0.acres > $1.acres }).prefix(8).indices,
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
                            GridItem(.fixed(230), spacing: 20), GridItem(.fixed(230), spacing: 20), GridItem(.fixed(230), spacing: 20), GridItem(.fixed(230), spacing: 20)
                        ], spacing: 20) {
                            ForEach(fireB.fires.sorted(by: { $0.updated > $1.updated }).prefix(8).indices, id: \.self) { index in
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
            .padding(.bottom, 70)
        }
        .edgesIgnoringSafeArea(.all)
    }
}
