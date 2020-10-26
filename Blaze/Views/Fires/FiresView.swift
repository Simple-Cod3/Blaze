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
    @State var show = false
    @State var done = false
    
    var body: some View {
        if done {
            NavigationView {
                ZStack(alignment: .top) {
                    ScrollView(showsIndicators: false) {
                        VStack {
                            Image("hydrant").resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 275)
                                .padding(40)
                            
                            NoticeCard(
                                title: "Deprecated Source",
                                text: "The current RSS source from fire.ca.gov has transfered monitoring ownership for multiple major fires. The source is now deemed as deprecated. The development team is currently working on a fix."
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
                            .background(Color(.secondarySystemBackground))
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
                            .background(Color(.secondarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        }
                        .padding(20)
                        
                        SubHeader(title: "Largest Fires", description: "Wildfires will be sorted according to their sizes from largest to smallest.")
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(
                                    fireB.fires.sorted(by: { $0.acres > $1.acres }).prefix(5).indices,
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
                        
                        SubHeader(title: "Latest Fires", description: "Recently updated fires will be shown first.")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(fireB.fires.sorted(by: { $0.updated > $1.updated }).prefix(5).indices, id: \.self) { index in
                                    NavigationLink(destination: FireMapView(fireData: fireB.fires.sorted(by: { $0.updated > $1.updated })[index])) {
                                        MiniFireCard(selected: index == selectAll, fireData: fireB.fires.sorted(by: { $0.updated > $1.updated })[index], area: false)
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
                            
                        HStack {
                            Text("Updates to fire data cannot be guaranteed on a set time schedule. Please use the information in Blaze only as a reference. This app is not meant to provide real-time evacuation or fire behavior information.")
                                .font(.caption)
                                .fontWeight(.regular)
                                .foregroundColor(.secondary)
                                .padding([.horizontal, .bottom], 20)
                            Spacer()
                        }
                        .navigationBarTitle("Wildfires", displayMode: .inline)
                        .navigationBarHidden(true)
                    }
                    .opacity(show ? 1 : 0)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            self.show = true
                        }
                    }
                    StatusBarBackground()
                }
            }
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
