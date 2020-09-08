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
                        .frame(height: 300)
                        .padding(25)
                    
                    HStack {
                        Header(title: "Wild Fires", desc: "Uncontrollable fires that spreads quickly over vegetation in rural areas. The scale of destruction is largely driven by weather conditions.")
                        Spacer()
                    }
                    
                    Spacer().frame(height: 50)
                    
                    Header2(title: "Largest Fires", description: "Largest fires (acres) will be shown first.")
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(
                                fireB.fires.sorted(by: { $0.acres > $1.acres }).indices,
                                id: \.self
                            ) { i in
                                Button(action: { selectLargest = i }) {
                                    MiniFireCard(
                                        selected: i == selectLargest,
                                        fireData: fireB.fires.sorted(by: { $0.acres > $1.acres })[i]
                                    )
                                }
                            }
                        }
                            .padding(20)
                    }
                    
                    Divider().padding(.horizontal, 20)
                    
                    
                    Header2(title: "All Fires", description: "Fires with more updated information will be listed first.")
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(fireB.fires.indices, id: \.self) { i in
                                Button(action: { selectAll = i }) {
                                    MiniFireCard(selected: i == selectAll, fireData: fireB.fires[i])
                                }
                            }
                        }
                            .padding(20)
                    }
                    
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
