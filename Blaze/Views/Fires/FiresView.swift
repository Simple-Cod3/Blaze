//
//  FiresView.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import SwiftUI

struct FiresView: View {
    @EnvironmentObject var fireB: FireBackend
    @State var select = 0
    
    let rows = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Image("hydrant").resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 300)
                        .padding(25)
                    
                    HStack {
                        Header(title: "Wild Fires", desc: "Uncontrollable fires that spreads quickly over vegetation in rural areas. The scale of destruction is largely driven by weather conditions.")
                        Spacer()
                    }
                    
                    Spacer()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(fireB.fires.indices, id: \.self) { i in
                                Button(action: { select = i }) {
                                    MiniFireCard(selected: i == select, fireData: fireB.fires[i])
                                }
                            }
                        }
                            .padding(20)
                    }
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
