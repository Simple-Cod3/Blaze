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
    
    let rows = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack {
                    Image("hydrant").resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
                        .padding(25)
                    
                    HStack {
                        Header(title: "Wild Fires", desc: "Uncontrollable fires that spreads quickly over vegetation in rural areas. The scale of destruction is largely driven by weather conditions.")
                        Spacer()
                    }
                    
                    Spacer().frame(height: 25)
                    
                    Header2(title: "Largest Fires", description: "Largest fires (acres) will be shown.")
                    
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
                    
                    
                    Header2(title: "Latest Fires", description: "Fires with more updated information will be listed first.")
                    
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
                    
                    Spacer().frame(height: 50)
                }
                    .navigationBarTitle("Big Fires", displayMode: .inline)
                .navigationBarHidden(true)
            }
        }
    }
}

struct FiresView_Previews: PreviewProvider {
    static var previews: some View {
        FiresView()
    }
}
