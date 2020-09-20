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
    @State var done = false
    
    var body: some View {
        if done {
            NavigationView {
                ScrollView(showsIndicators: false) {
                    VStack {
                        Image("hydrant").resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 250)
                            .padding(35)
                        
                        HStack {
                            Header(title: "Wild Fires", desc: "Uncontrollable fires that spreads quickly over vegetation in rural areas. The scale of destruction is largely driven by weather conditions.")
                            Spacer()
                        }
                        
                        HStack(spacing: 20) {
                            NavigationLink(destination: FullFireMapView()) {
                                HStack {
                                    Spacer()
                                    Text("\(Image(systemName: "map")) Fire Map")
                                        .fontWeight(.semibold)
                                        .foregroundColor(.blaze)
                                    Spacer()
                                }
                            }
                                .padding(12)
                                .background(Color(.secondarySystemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            NavigationLink(destination: DataView()) {
                                HStack {
                                    Spacer()
                                    Text("\(Image(systemName: "tray.2")) Data")
                                        .fontWeight(.semibold)
                                        .foregroundColor(.blaze)
                                    Spacer()
                                }
                            }
                                .padding(12)
                                .background(Color(.secondarySystemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        }.padding(20)
                        
                        
                        Header2(title: "Largest Fires", description: "Largest fires (measured in acres) will be shown.")
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(
                                    fireB.fires.sorted(by: { $0.acres > $1.acres }).prefix(5).indices,
                                    id: \.self
                                ) { i in
                                    NavigationLink(destination: FireMapView(fireData: fireB.fires.sorted(by: { $0.acres > $1.acres })[i])) {
                                        MiniFireCard(
                                            selected: i == selectLargest,
                                            fireData: fireB.fires.sorted(by: { $0.acres > $1.acres })[i]
                                        )
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
                            .edgesIgnoringSafeArea(.horizontal)

                        Divider().padding(20)
                        
                        
                        Header2(title: "Latest Fires", description: "Recently updated fires will be shown first.")
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(fireB.fires.prefix(5).indices, id: \.self) { i in
                                    NavigationLink(destination: FireMapView(fireData: fireB.fires[i])) {
                                        MiniFireCard(selected: i == selectAll, fireData: fireB.fires[i])
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
                            .edgesIgnoringSafeArea(.horizontal)
                        
                        Text("Updates to fire data cannot be guaranteed on a set time schedule. Please use the information in this app only as a reference. Blaze is not meant to provide up to the minute evacuation or fire behavior information.")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.secondary)
                            .padding([.horizontal, .bottom], 20)
                        
                    }
                        .navigationBarTitle("Wild Fires", displayMode: .inline)
                        .navigationBarHidden(true)
                }
            }
        }
        else if fireB.failed {
            VStack(spacing: 20) {
                Image(systemName: "wifi.exclamationmark")
                    .font(.system(size: 30))
                    .foregroundColor(.blaze)
                
                Text("No Connection")
                    .font(.title)
                    .fontWeight(.bold)
                
                Button("Click to Retry", action: { fireB.refreshFireList() })
            }
        }
        else {
            ProgressBarView(
                progressObj: $fireB.progress,
                progress: $progress,
                done: $done,
                text: "Fires"
            )
        }
    }
}

struct FiresView_Previews: PreviewProvider {
    static var previews: some View {
        FiresView().environmentObject(FireBackend())
    }
}
